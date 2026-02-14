import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;

class AnalyzeService {
  static const _unusedCodes = {
    'unused_element',
    'unused_field',
    'unused_import',
    'unused_local_variable',
    'dead_code',
  };

  Future<List<Map<String, dynamic>>> getAllUnused({String? rootDir}) async {
    return _runAnalyze(rootDir, _unusedCodes);
  }

  Future<List<Map<String, dynamic>>> getUnusedImports({String? rootDir}) async {
    return _runAnalyze(rootDir, {'unused_import'});
  }

  Future<List<Map<String, dynamic>>> getUnusedFields({String? rootDir}) async {
    return _runAnalyze(rootDir, {'unused_field'});
  }

  Future<List<Map<String, dynamic>>> getUnusedLocalVariables({String? rootDir}) async {
    return _runAnalyze(rootDir, {'unused_local_variable'});
  }

  Future<List<Map<String, dynamic>>> getUnusedElements({String? rootDir}) async {
    return _runAnalyze(rootDir, {'unused_element'});
  }

  Future<List<Map<String, dynamic>>> _runAnalyze(
      String? rootDir, Set<String> targetCodes) async {
    final directory = rootDir != null ? Directory(rootDir) : Directory.current;
    
    if (!directory.existsSync()) {
      throw Exception('Directory not found: ${directory.path}');
    }

    try {
      final result = await Process.run(
        'dart',
        ['analyze', '--format=json'],
        workingDirectory: directory.path,
      );

      final output = result.stdout.toString();
      final jsonStart = output.indexOf('{');
      final jsonEnd = output.lastIndexOf('}');
      
      if (jsonStart == -1 || jsonEnd == -1) {
          if (result.exitCode != 0 && result.stderr.toString().isNotEmpty) {
             throw Exception('Dart analyze failed: ${result.stderr}');
          }
          return [];
      }
      
      final jsonString = output.substring(jsonStart, jsonEnd + 1);
      final Map<String, dynamic> data = jsonDecode(jsonString);
      
      final List<dynamic> diagnostics = data['diagnostics'] ?? [];
      
      return diagnostics
          .where((d) => targetCodes.contains(d['code']))
          .map((d) => {
                'code': d['code'],
                'severity': d['severity'],
                'type': d['type'],
                'location': {
                  'file': p.normalize(p.absolute(directory.path, d['location']['file'])),
                  'range': d['location']['range'],
                },
                'problemMessage': d['problemMessage'],
              })
          .toList();

    } catch (e) {
      throw Exception('Failed to run dart analyze: $e');
    }
  }
}

import 'package:flutter_cleanup_mcp/src/services/analyze_service.dart';
import 'package:test/test.dart';
import 'dart:io';
import 'package:path/path.dart' as p;

void main() {
  group('AnalyzeService', () {
    late AnalyzeService service;
    late String exampleDir;

    setUp(() {
      service = AnalyzeService();
      exampleDir = p.join(Directory.current.path, 'example');
    });

    test('getAllUnused returns unused elements', () async {
      final results = await service.getAllUnused(rootDir: exampleDir);
      
      expect(results, isNotEmpty);
      
      final unusedImport = results.firstWhere((r) => r['code'] == 'unused_import', orElse: () => {});
      expect(unusedImport, isNotEmpty, reason: 'Should find unused_import');
      expect(unusedImport['problemMessage'], contains("Unused import: 'dart:async'"));

      final unusedLocal = results.firstWhere((r) => r['code'] == 'unused_local_variable', orElse: () => {});
      expect(unusedLocal, isNotEmpty, reason: 'Should find unused_local_variable');
      expect(unusedLocal['problemMessage'], contains("The value of the local variable 'unusedLocal' isn't used"));

      final unusedElement = results.firstWhere((r) => r['code'] == 'unused_element', orElse: () => {});
      expect(unusedElement, isNotEmpty, reason: 'Should find unused_element');
       // Note: unusedFunction might be reported as unused_element
    });
  });
}

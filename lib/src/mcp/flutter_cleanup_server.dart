import 'dart:convert';
import 'package:mcp_dart/mcp_dart.dart';

import 'package:flutter_cleanup_mcp/src/services/analyze_service.dart';

class FlutterCleanupServer {
  FlutterCleanupServer(this._server) {
    _registerTools();
  }

  final McpServer _server;
  final AnalyzeService _analyzeService = AnalyzeService();

  void _registerTools() {
    _server.registerTool('get_unused_all',
        description: 'Get all unused code (imports, fields, locals, elements) in the project.',
        inputSchema: ToolInputSchema.fromJson({
          'type': 'object',
          'properties': {
            'rootDir': {
              'type': 'string',
              'description': 'The root directory of the Flutter/Dart project. Defaults to current working directory.'
            },
          },
        }), callback: (Map<String, Object?> args, dynamic context) async {
      final rootDir = args['rootDir'] as String?;
      final result = await _analyzeService.getAllUnused(rootDir: rootDir);
      return CallToolResult(content: [
        TextContent(
          text: jsonEncode(result),
        )
      ]);
    });

    _server.registerTool('get_unused_imports',
        description: 'Get unused imports in the project.',
        inputSchema: ToolInputSchema.fromJson({
          'type': 'object',
          'properties': {
            'rootDir': {
              'type': 'string',
              'description': 'The root directory of the Flutter/Dart project.'
            },
          },
        }), callback: (Map<String, Object?> args, dynamic context) async {
      final rootDir = args['rootDir'] as String?;
      final result = await _analyzeService.getUnusedImports(rootDir: rootDir);
      return CallToolResult(content: [
        TextContent(
          text: jsonEncode(result),
        )
      ]);
    });

    _server.registerTool('get_unused_fields',
        description: 'Get unused fields in the project.',
        inputSchema: ToolInputSchema.fromJson({
          'type': 'object',
          'properties': {
            'rootDir': {
              'type': 'string',
              'description': 'The root directory of the Flutter/Dart project.'
            },
          },
        }), callback: (Map<String, Object?> args, dynamic context) async {
      final rootDir = args['rootDir'] as String?;
      final result = await _analyzeService.getUnusedFields(rootDir: rootDir);
      return CallToolResult(content: [
        TextContent(
          text: jsonEncode(result),
        )
      ]);
    });

    _server.registerTool('get_unused_local_variables',
        description: 'Get unused local variables in the project.',
        inputSchema: ToolInputSchema.fromJson({
          'type': 'object',
          'properties': {
            'rootDir': {
              'type': 'string',
              'description': 'The root directory of the Flutter/Dart project.'
            },
          },
        }), callback: (Map<String, Object?> args, dynamic context) async {
      final rootDir = args['rootDir'] as String?;
      final result = await _analyzeService.getUnusedLocalVariables(rootDir: rootDir);
      return CallToolResult(content: [
        TextContent(
          text: jsonEncode(result),
        )
      ]);
    });

    _server.registerTool('get_unused_elements',
        description: 'Get unused elements (functions, classes, etc.) in the project.',
        inputSchema: ToolInputSchema.fromJson({
          'type': 'object',
          'properties': {
            'rootDir': {
              'type': 'string',
              'description': 'The root directory of the Flutter/Dart project.'
            },
          },
        }), callback: (Map<String, Object?> args, dynamic context) async {
      final rootDir = args['rootDir'] as String?;
      final result = await _analyzeService.getUnusedElements(rootDir: rootDir);
      return CallToolResult(content: [
        TextContent(
          text: jsonEncode(result),
        )
      ]);
    });
  }
}

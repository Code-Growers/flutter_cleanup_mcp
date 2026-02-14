import 'dart:io';

import 'package:args/args.dart';
import 'package:logging/logging.dart' as logging;
import 'package:mcp_dart/mcp_dart.dart';
import 'package:flutter_cleanup_mcp/src/compat/copilot_stdio_server_transport.dart';
import 'package:flutter_cleanup_mcp/src/mcp/flutter_cleanup_server.dart';

void main(List<String> arguments) async {
  logging.Logger.root.level = logging.Level.ALL;
  logging.Logger.root.onRecord.listen((record) {
    stderr.writeln(
        '[${record.level.name}] ${record.loggerName}: ${record.message}');
    if (record.error != null) {
      stderr.writeln(record.error);
    }
    if (record.stackTrace != null) {
      stderr.writeln(record.stackTrace);
    }
  });

  final logger = logging.Logger('Main');

  final parser = ArgParser()
    ..addOption('sse-port',
        help:
            'Port to run the SSE server on (Not yet implemented, defaults to Stdio)');

  final argResults = parser.parse(arguments);
  final ssePortStr = argResults['sse-port'] as String?;

  Transport transport;

  if (ssePortStr != null) {
    logger.severe('SSE transport is not yet implemented in this version.');
    exit(1);
  } else {
    logger.info('Starting Flutter Cleanup MCP Server using Stdio Transport');
    transport = CopilotCompatStdioServerTransport();
  }

  final implementation = Implementation(
    name: 'flutter-cleanup-mcp',
    version: '0.1.0',
  );

  final server = McpServer(implementation);

  FlutterCleanupServer(server);

  await server.connect(transport);

  logger.info('Server started and listening...');
}

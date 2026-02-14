import 'dart:async';
import 'package:flutter_cleanup_mcp/src/mcp/flutter_cleanup_server.dart';
import 'package:mcp_dart/mcp_dart.dart';
import 'package:test/test.dart';

class MockMcpServer implements McpServer {
  final Map<String, Function> registeredTools = {};

  @override
  RegisteredTool registerTool(String name,
      {ToolAnnotations? annotations,
      required FutureOr<CallToolResult> Function(
              Map<String, dynamic>, RequestHandlerExtra)
          callback,
      String? description,
      JsonObject? inputSchema,
      Map<String, dynamic>? meta,
      JsonObject? outputSchema,
      String? title}) {
    registeredTools[name] = callback;
    return MockRegisteredTool(name);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class MockRegisteredTool implements RegisteredTool {
  @override
  final String name;

  MockRegisteredTool(this.name);
  
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  group('FlutterCleanupServer', () {
    late MockMcpServer mockServer;
    // ignore: unused_local_variable
    late FlutterCleanupServer server;

    setUp(() {
      mockServer = MockMcpServer();
      server = FlutterCleanupServer(mockServer);
    });

    test('registers all cleanup tools', () {
      final expectedTools = [
        'get_unused_all',
        'get_unused_imports',
        'get_unused_fields',
        'get_unused_local_variables',
        'get_unused_elements',
      ];

      for (final tool in expectedTools) {
        expect(mockServer.registeredTools.containsKey(tool), isTrue,
            reason: 'Tool $tool should be registered');
      }
    });
  });
}

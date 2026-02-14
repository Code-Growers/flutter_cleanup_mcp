# Example Project for Flutter Cleanup MCP

This example project contains intentional unused code to demonstrate the capabilities of the `flutter_cleanup_mcp` server.

## Contents

- `lib/unused_code.dart`: Contains various unused elements (imports, private functions, classes, fields, locals).
- `lib/main.dart`: Standard Flutter counter app.

## Testing the MCP Server

1. **Configure MCP**: Ensure your MCP client is pointing to the `flutter_cleanup_mcp` server.
2. **Connect**: Open this folder in your IDE.
3. **Run Tools**: Use the MCP tools to find unused code in this project.
    - `get_unused_all`: Should return a list of unused items from `lib/unused_code.dart`.
    - Try `get_unused_imports`, `get_unused_local_variables`, etc.
4. **Clean Up**: You can use an AI agent to automatically remove the unused code identified by the server.

# Flutter Cleanup MCP Server

MCP server designed to help AI agents clean up dead code in Flutter/Dart projects. It provides tools to identify unused elements, imports, fields, and local variables.

## Key Features

- **Identify Unused Code**: Automatically detect unused imports, fields, local variables, and other elements.
- **Agent-Ready Output**: Tools return structured JSON data with file paths, lines, and columns, making it easy for AI agents to precisely locate and remove dead code.
- **Safe**: The MCP server *identifies* code to remove but does *not* delete it automatically, leaving the final decision and execution to the agent or user.

## Installation

1. Clone this repository.
2. Run `dart pub get` to install dependencies.

## Configuration

### VS Code (with MCP Extension)

Add the following to your MCP settings file (e.g., `~/.vscode/mcp.json`):

```json
{
  "servers": {
    "flutter_cleanup": {
      "command": "dart",
      "args": [
        "/absolute/path/to/flutter_cleanup_mcp/bin/flutter_cleanup_mcp.dart"
      ]
    }
  }
}
```

## Available Tools

- **`get_unused_all`**: Returns a consolidated list of all unused code detected.
- **`get_unused_imports`**: Returns only unused imports.
- **`get_unused_fields`**: Returns only unused class fields.
- **`get_unused_local_variables`**: Returns only unused local variables.
- **`get_unused_elements`**: Returns other unused elements (functions, classes, methods).

Each tool accepts an optional `rootDir` argument. If not provided, it defaults to the current working directory.

## Usage Example

An AI agent can use these tools to clean up a project:

1. Call `get_unused_all`.
2. Iterate through the results.
3. For each item, read the file and remove the specific line/range.
4. Run `get_unused_all` again to verify.

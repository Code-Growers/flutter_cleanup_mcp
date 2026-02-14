# Flutter Cleanup MCP Server

MCP server designed to help AI agents clean up dead code in Flutter/Dart projects. It provides tools to identify unused elements, imports, fields, and local variables.

## Why use this?

This tool is particularly useful for **AI-assisted coding workflows**. AI agents often generate unused, test, duplicate, or "hallucinated" code (e.g., extra imports, unused helper functions). Cleaning this up manually is tedious, and leaving it in consumes valuable **tokens** and **context window** space. Furthermore, by removing dead code, the AI agent can stay more **focused**, decreasing the likelihood of choosing the wrong function or context, which can lead to bugs. This MCP server empowers agents to self-correct and keep the codebase lean, saving costs and improving model performance.

## Installation

Run the following command to activate the `flutter_cleanup_mcp` [global tool](https://dart.dev/tools/pub/cmd/pub-global):

```bash
dart pub global activate flutter_cleanup_mcp
```

## Tool Configuration

Add the MCP server to your AI coding assistant's configuration.

### Cursor

Add to your project's `.cursor/mcp.json` or your global `~/.cursor/mcp.json`:

```json
{
  "mcpServers": {
    "flutter_cleanup": {
      "command": "flutter_cleanup_mcp",
      "args": []
    }
  }
}
```

### Claude Code

You can run the following command to add it:

```bash
claude mcp add --transport stdio flutter_cleanup_mcp -- flutter_cleanup_mcp
```

### VS Code (with MCP Extension)

Add the following to your MCP settings file (e.g., `~/.vscode/mcp.json`):

```json
{
  "servers": {
    "flutter_cleanup": {
      "command": "flutter_cleanup_mcp",
      "args": []
    }
  }
}
```

## Key Features

- **Identify Unused Code**: Automatically detect unused imports, fields, local variables, and other elements.
- **Agent-Ready Output**: Tools return structured JSON data with file paths, lines, and columns, making it easy for AI agents to precisely locate and remove dead code.
- **Safe**: The MCP server *identifies* code to remove but does *not* delete it automatically, leaving the final decision and execution to the agent or user.

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

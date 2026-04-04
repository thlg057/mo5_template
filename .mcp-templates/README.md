# MCP Server Configuration

This directory contains templates and instructions for configuring the **mo5-rag** MCP server with different AI coding agents.

---

## VS Code + GitHub Copilot

**Location**: `.vscode/settings.json` (at project root)

Configuration is already included in the project.

```json
{
  "mcpServers": {
    "mo5-rag": {
      "command": "node",
      "args": ["./tools/mcp_mo5/index.js"],
      "env": {
        "RAG_BASE_URL": "https://retrocomputing-ai.cloud"
      }
    }
  }
}
```

---

## Claude Desktop

**Installation**: [Claude Desktop](https://claude.ai/download)

### Setup Instructions

1. Copy the contents of `claude_desktop_config.json` from this directory
2. Create or edit the configuration file at one of these locations:
   - **macOS**: `~/Library/Application Support/Claude/claude_desktop_config.json`
   - **Linux**: `~/.config/Claude/claude_desktop_config.json`
   - **Windows**: `%APPDATA%\Claude\claude_desktop_config.json`
3. Paste the configuration content into your `claude_desktop_config.json`
4. Close and restart Claude Desktop

The template already contains the correct absolute path to your MO5 project.

---

## Augment

### Setup Instructions

1. Copy the contents of `augment_config.json` from this directory
2. Locate Augment's configuration directory (see Augment documentation)
3. Create or edit your MCP configuration file
4. Paste the configuration content
5. Restart Augment

The template already contains the correct absolute path to your MO5 project.

---

## What These Configs Enable

With the mo5-rag MCP server configured, the agent can:
- ✓ Call tools exposed by the MO5 RAG server
- ✓ Query MO5 documentation and examples
- ✓ Access MO5 development patterns via RAG
- ✓ Develop MO5 C programs with full context

---

## Notes

- The VS Code configuration uses a relative path (`./tools/mcp_mo5/index.js`) because it runs within the project context
- Claude Desktop and Augment use absolute paths because they run globally on your system
- After configuration, restart the application to load the MCP server

# MCP Server Configuration

This directory contains sample configuration files for connecting the 
**mo5-rag** MCP server to your AI coding agent.

---

## Quick Setup

All configurations use `npx` — no local installation required.  
Just copy the relevant snippet into your agent's config file and restart.

```json
{
  "mcpServers": {
    "mo5-rag": {
      "command": "npx",
      "args": ["-y", "@thlg057/mo5-rag-mcp"],
      "env": {
        "RAG_BASE_URL": "https://retrocomputing-ai.cloud"
      }
    }
  }
}
```

---

## VS Code + GitHub Copilot

**File**: `.vscode/settings.json` (at project root)

Copy `vscode_settings.json` from this directory into `.vscode/settings.json`.

---

## Claude Desktop

**File location:**
- **macOS**: `~/Library/Application Support/Claude/claude_desktop_config.json`
- **Linux**: `~/.config/Claude/claude_desktop_config.json`
- **Windows**: `%APPDATA%\Claude\claude_desktop_config.json`

Copy the contents of `claude_desktop_config.json` from this directory 
into your config file, then restart Claude Desktop.

---

## Augment / Cursor

Copy the contents of `augment_config.json` from this directory into 
your agent's MCP configuration, then restart the agent.

---

## What This Enables

Once configured, your agent can:
- ✓ Query MO5 hardware and system documentation
- ✓ Access CMOC compiler reference
- ✓ Use SDK module documentation in natural language
- ✓ Get guidance on game dev patterns (VBL, sprites, collisions, RLE…)
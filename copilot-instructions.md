# MO5 C Development Instructions

## Purpose

These instructions help a coding agent understand and work with MO5 C programming projects. The Thomson MO5 is a retro-computer, and development requires knowledge of the MO5 SDK and various asset transformation tools.

## MO5 SDK Documentation

The MO5 C SDK provides the following modules (referenced in `tools/docs/`):

- **mo5_actor_dr.h** - Actor/character management
- **mo5_ctype.h** - Character type classification
- **mo5_defs.h** - Core definitions and constants
- **mo5_sprite.h** - Sprite manipulation and rendering
- **mo5_sprite_bg.h** - **Sprite with transparent background (RECOMMENDED)** — Use this for drawing and moving sprites with transparency
- **mo5_sprite_form.h** - Sprite form structures
- **mo5_sprite_types.h** - Sprite type definitions
- **mo5_stdio.h** - Standard I/O functions
- **mo5_utils.h** - Utility functions
- **mo5_video.h** - Video and display management
- **cmoc/** - CMOC compiler documentation (assert, setjmp, stdarg, etc.)

All header files (.h) are located in `tools/include/`.

## Development Tools

**Asset Conversion**
- **png2mo5.py** (in `tools/scripts/`) - Converts PNG images to C structures for MO5 sprite programming. Essential for creating game graphics and visual assets that can be used in MO5 C code.

## ⛔ IMPORTANT: Do Not Modify `tools/` Directory

**The `tools/` directory contains:**
- SDK headers and libraries (`tools/include/`, `tools/lib/`)
- SDK documentation (`tools/docs/`)
- External tools and compilers (BootFloppyDisk, scripts)
- MCP server (`tools/mcp_mo5/`)

**❌ DO NOT modify any files in `tools/`** — These are external dependencies and infrastructure.

**✅ Only modify:**
- `src/` — Your C source files
- `include/` — Your project header files
- `assets/` — Your game images and assets
- `Makefile` — Build configuration (PROJ_SRC, PROJ_HDR, PROGRAM)

Modifying tools can break the build system or corrupt the SDK.

## Knowledge Resources

The **mo5-rag** MCP server provides:
- Retrieval Augmented Generation (RAG) for MO5 knowledge queries
- Access to MO5 development patterns and best practices
- Query the server when needing contextual information about MO5 programming

## Build System Rules

When developing MO5 C programs with this template:

### Build Command
- **Only run**: `make`
- The Makefile handles everything: compilation, linking, disk image creation (.fd → .sd)

### Program Name
- **Define in Makefile**: Set the `PROGRAM` variable (uppercase, max 6 characters)
- **Example**: `PROGRAM := MYGAME` or `PROGRAM := SPRITE`
- **Output files**: Will be named after this variable (e.g., `MYGAME.BIN`, `MYGAME.fd`, `MYGAME.sd`)

### Program Structure
- **main() must contain**: `while (1) { /* your code */ }` - otherwise the program exits immediately
- All program logic goes inside the infinite loop

### File Organization
- **.c files**: Place in `./src/` and add to `PROJ_SRC` in Makefile
- **.h files**: Place in `./include/` and add to `PROJ_HDR` in Makefile
- **SDK headers**: Already included automatically, don't worry about them
- **SDK library**: Already linked automatically

### Asset Management
- **Image location**: Place PNG images in `./assets/` directory
- **Convert to sprite**: Use `make convert IMG=./assets/sprite.png`
- **Output**: Creates a `.h` file in `./include/` with sprite data structures
- **⚠️ IMPORTANT**: After converting a PNG to sprite header, **add the generated `.h` file to `PROJ_HDR` in the Makefile**
  - Example: If you convert `assets/player.png`, it creates `include/assets/player.h`
  - You must then add it to Makefile:
    ```makefile
    PROJ_HDR := include/assets/player.h
    ```
  - This ensures the sprite header is available during compilation
- **Usage**: Include the generated header in your `.c` files and use the sprite structures (e.g., `SPRITE_PLAYER_INIT`)

### Sprite Display and Movement
- **Always use `mo5_sprite_bg.h`** for displaying and moving sprites
- Functions in `mo5_sprite_bg.h` handle **transparency** by preserving the background color
- When converting PNG assets to sprites, ensure the background pixels have `foreground = 0x0` for transparency to work
- Example functions: `mo5_actor_draw_bg()`, `mo5_actor_move_bg()`, `mo5_actor_clear_bg()`
- See `tools/docs/mo5_sprite_bg_h.md` for detailed API documentation
### Adding Files
If you add new source files:
1. Create `.c` files in `./src/` and add to `PROJ_SRC` in Makefile
2. Create `.h` files in `./include/` and add to `PROJ_HDR` in Makefile
3. This includes generated sprite headers from `make convert` — they must also be listed in `PROJ_HDR`

When developing MO5 C code:
1. Consult `tools/docs/` for SDK module documentation
2. Include headers from `tools/include/` as needed
3. Use `png2mo5.py` for sprite/asset creation
4. Use the mo5-rag MCP server to query for implementation guidance

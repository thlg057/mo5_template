# 🕹️ Thomson MO5 Project Template

This repository is a template for developing software and games for the **Thomson MO5** using the C language.  
It automates environment setup, SDK management, and the creation of bootable disk images.

## 📁 Project Structure

- **src/** : Contains your application source code (e.g. `main.c`).
- **tools/** : Generated folder containing the SDK (libraries and headers) as well as conversion utilities.
- **bin/** : Contains the `.BIN` executable after compilation.
- **output/** : Contains the final disk images in `.fd` and `.sd` formats.

## 🛠️ Prerequisites

- **CMOC** : The C compiler for the 6809 processor.
- **Git** : Required to clone dependency tools during installation.
- **Python 3 / Pillow** : Required for conversion scripts (`fd2sd.py` and `png2mo5.py`).

### 📦 Installation on GitHub Codespaces

If you are using GitHub Codespaces, you can automatically install all prerequisites with:

```bash
make setup-codespace
```

This command installs:
- **flex** (required for lwtools)
- **Pillow** (Python library for image conversion)
- **lwtools** (6809 assembler)
- **CMOC** (C compiler for 6809)
- **Python 3 / Pillow** : Required for the image processing script `png2mo5.py`.

## 🚀 Setup and Compilation

### 1. Customization

Open the `Makefile` at the root of the project and modify the following variable to define your program name:

```makefile
PROGRAM := MYAPP
```

(Replace `MYAPP` with your desired name.)

### 2. Environment Installation

Before compiling for the first time, run the following command to set up the SDK and system tools:

```bash
make install
```

This command:
- downloads and compiles the **sdk_mo5**, an SDK designed to simplify development on Thomson MO5. The SDK also includes Python scripts to generate disk files in fd and sd formats (compatible with SDDrive)
  👉 https://github.com/thlg057/sdk_mo5.git
- exports all necessary files into the `tools/` folder

### 3. Project Compilation

To generate your program and disk images, simply use:

```bash
make
```

This action will compile your source code, link it with the SDK library, and create disk images (.fd and .sd) in the `output/` folder.

## 📖 SDK Usage

The **mo5_sdk** is based on the *helper* code from the **sdk_mo5** project, which gathers a set of functions I developed to simplify and speed up development on Thomson MO5.

To use these functions in your code, include the exported header files:

```c
#include <mo5_stdio.h>
#include <mo5_defs.h>
```

The `Makefile` automatically handles include paths (`-Itools/include`) and links the static library (`tools/lib/libsdk_mo5.a`) during compilation.

## 🎨 PNG Image to Sprite Conversion

The project includes a Python script that converts a PNG image into a `.h` file containing the C definition of the corresponding sprite.

To convert an image:

```bash
make convert IMG=./assets/sprite.png
```

This command:
- Analyzes the PNG image and automatically detects colors (2 colors per group of 8 pixels)
- Automatically generates the file `include/assets/sprite1.h` with the sprite definition
- Creates necessary directories if needed
- Preserves the folder structure (e.g. `./assets/perso/hero.png` → `./include/assets/perso/hero.h`)

The generated file contains:
- **SHAPE** data (1 bit/pixel bitmap)
- **COLOR** data (attributes per group of 8 pixels)
- Comments with ASCII visualization of the sprite

You can then include the generated file in your code:

```c
#include "assets/sprite1.h"
```

## 🧹 Cleaning

- `make clean` : Removes project build files (object files, binaries, and disk images).
- `make clean-all` : Removes the entire project including the `tools/` folder (SDK and tools included).

## 🤖 AI Assistant Integration (MCP)

This template is designed to work with the **Model Context Protocol (MCP)**.  
Connect your AI coding agent (Claude Desktop, Cursor, Augment…) to the MO5 
knowledge base, and it instantly becomes an expert: 6809, CMOC, SDK, 
game development patterns, and more.

### Configuration

Just add this to your agent's configuration file:

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

No installation, no path to configure. `npx` downloads and runs the server 
on the fly. 🎉

Sample configuration files for Claude Desktop, Cursor and Augment are 
available in the `.mcp-templates/` folder.

### The full ecosystem

- 🛠️ **SDK MO5** : https://github.com/thlg057/sdk_mo5
- 📦 **This template** : https://github.com/thlg057/mo5_template
- 🤖 **MCP Server** : https://www.npmjs.com/package/@thlg057/mo5-rag-mcp
- 🌐 **Knowledge base** : https://retrocomputing-ai.cloud
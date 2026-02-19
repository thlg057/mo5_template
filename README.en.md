# 🕹️ Thomson MO5 Project Template

This repository is a template for developing software and games for the **Thomson MO5** using the C programming language.  
It automates environment setup, SDK management, and the creation of bootable floppy disk images.

## 📁 Project Structure

- **src/** : Contains the source code of your application (e.g. `main.c`).
- **tools/** : Generated directory containing the SDK (libraries and headers) as well as conversion utilities.
- **bin/** : Contains the compiled `.BIN` executable.
- **output/** : Contains the final floppy disk images in `.fd` and `.sd` formats.

## 🛠️ Requirements

- **CMOC** : C compiler for the 6809 processor.
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

## 🚀 Setup and Build

### 1. Customization

Open the `Makefile` at the root of the project and modify the following variable to define your program name:

```makefile
PROGRAM := MYAPP
```

(Replace `MYAPP` with the desired name.)

### 2. Environment Installation

Before compiling for the first time, run the following command to set up the SDK and system tools:

```bash
make install
```

This command:
- downloads and uses the **BootFloppyDisk** project to generate bootable floppy disk images  
  👉 https://github.com/OlivierP-To8/BootFloppyDisk.git
- compiles **sdk_mo5**, which is based on the *helper* code developed to simplify development on the Thomson MO5  
  👉 https://github.com/thlg057/sdk_mo5.git
- exports all required files into the `tools/` directory

### 3. Project Build

To generate your program and disk images, simply run:

```bash
make
```

This will compile your source code, link it against the SDK library, and create the storage files in the `output/` directory.

## 📖 SDK Usage

The **mo5_sdk** is built on top of the *helper* code from the **sdk_mo5** project, which groups together a set of functions I developed to make Thomson MO5 development easier and faster.

To use these functions in your code, include the exported header files:

```c
#include <mo5_stdio.h>
#include <mo5_defs.h>
```

The `Makefile` automatically handles include paths (`-Itools/include`) and links the static library (`tools/lib/libsdk_mo5.a`) during compilation.

## 🎨 PNG to Sprite Conversion

The project includes a Python script that transforms a PNG image into a `.h` file containing the corresponding C sprite definition.

To convert an image:

```bash
make convert IMG=./assets/sprite1.png
```

This command:
- Analyzes the PNG image and automatically detects colors (2 colors per 8-pixel group)
- Automatically generates the file `include/assets/sprite1.h` with the sprite definition
- Creates necessary directories if needed
- Preserves the folder structure (e.g., `./assets/char/hero.png` → `./include/assets/char/hero.h`)

The generated file contains:
- **FORM** data (1 bit/pixel bitmap)
- **COLOR** data (attributes per 8-pixel group)
- Comments with ASCII visualization of the sprite

You can then include the generated file in your code:

```c
#include "assets/sprite1.h"
```

## 🧹 Cleaning

- `make clean` : Removes project build files (object files, binaries, and disk images).
- `make clean-all` : Removes the entire project, including the `tools/` directory (SDK and tools included).

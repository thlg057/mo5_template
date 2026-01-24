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
- **Python 3** : Required for the `fd2sd.py` conversion script.

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

## 🧹 Cleaning

- `make clean` : Removes project build files (object files, binaries, and disk images).
- `make clean-all` : Removes the entire project, including the `tools/` directory (SDK and tools included).

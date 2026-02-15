# Prerequisites Installation — MO5 Development

This page describes how to install all the tools required to compile and develop programs for the **MO5** from a Linux environment (or Codespaces / WSL / Ubuntu VPS).

---

# 1️⃣ System dependencies installation

Update package lists:

```bash
sudo apt update
```

Install required build tools and dependencies:

```bash
sudo apt install build-essential flex bison libboost-all-dev libxml2-dev zlib1g-dev wget tar
```

---

# 2️⃣ Installing lwtools

Download:

(last version can be found here: http://gvlsywt.cluster051.hosting.ovh.net/dev/cmoc.html#download)

```bash
wget http://www.lwtools.ca/releases/lwtools/lwtools-4.24.tar.gz
```

Extract:

```bash
tar -xzf lwtools-4.24.tar.gz
cd lwtools-4.24
```

Build and install:

```bash
make
sudo make install
```

---

# 3️⃣ Installing CMOC

Download:

```bash
wget http://gvlsywt.cluster051.hosting.ovh.net/dev/cmoc-0.1.97.tar.gz
```

Extract:

```bash
tar -xzf cmoc-0.1.97.tar.gz
cd cmoc-0.1.97
```

Configure, build and install:

```bash
./configure
make
sudo make install
```

---

# 4️⃣ Verifying CMOC installation

```bash
cmoc --version
```

If the version is displayed, the installation is successful ✅

---

# 5️⃣ Verifying Python

```bash
python3 --version
pip3 --version
```

---

# 6️⃣ Installing Python (if needed)

```bash
sudo apt update
sudo apt install python3 python3-pip python3-venv
```

---

# 7️⃣ Installing Python dependencies

Example:

```bash
pip install Pillow
```

---

# ✅ Environment ready

At this point you have:

- lwtools installed  
- cmoc installed  
- python operational  
- pip working  

You are ready to compile MO5 projects and use utility scripts (image conversion, tooling, etc.).

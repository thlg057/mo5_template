# Installation des prérequis — Développement MO5

Cette page décrit l’installation de tous les outils nécessaires pour compiler et développer des programmes pour le **MO5** depuis un environnement Linux (ou Codespaces / WSL / VPS Ubuntu).

---

# 1️⃣ Installation des dépendances système

Mettre à jour la liste des paquets :

```bash
sudo apt update
```

Installer les outils de compilation et dépendances nécessaires :

```bash
sudo apt install build-essential flex bison libboost-all-dev libxml2-dev zlib1g-dev wget tar
```

---

# 2️⃣ Installation de lwtools

Téléchargement :

```bash
wget http://www.lwtools.ca/releases/lwtools/lwtools-4.24.tar.gz
```

Extraction :

```bash
tar -xzf lwtools-4.24.tar.gz
cd lwtools-4.24
```

Compilation et installation :

```bash
make
sudo make install
```

---

# 3️⃣ Installation de CMOC

Téléchargement :

(Prendre la dernière version ici: http://gvlsywt.cluster051.hosting.ovh.net/dev/cmoc.html#download)

```bash
wget http://gvlsywt.cluster051.hosting.ovh.net/dev/cmoc-0.1.97.tar.gz
```

Extraction :

```bash
tar -xzf cmoc-0.1.97.tar.gz
cd cmoc-0.1.97
```

Configuration, compilation et installation :

```bash
./configure
make
sudo make install
```

---

# 4️⃣ Vérification de l’installation CMOC

```bash
cmoc --version
```

Si la version s’affiche, l’installation est OK ✅

---

# 5️⃣ Vérification de Python

```bash
python3 --version
pip3 --version
```

---

# 6️⃣ Installation de Python (si nécessaire)

```bash
sudo apt update
sudo apt install python3 python3-pip python3-venv
```

---

# 7️⃣ Installation des dépendances Python

Exemple :

```bash
pip install Pillow
```

---

# ✅ Environnement prêt

À ce stade, vous avez :

- lwtools installé  
- cmoc installé  
- python opérationnel  
- pip fonctionnel  

Vous êtes prêt à compiler les projets MO5 et utiliser les scripts utilitaires (conversion d’images, tooling, etc.).

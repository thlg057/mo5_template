# 🕹️ Thomson MO5 Project Template

Ce dépôt est un modèle (template) pour le développement de logiciels et de jeux sur **Thomson MO5** en langage C.  
Il automatise l'installation de l'environnement, la gestion du SDK et la création d'images disques bootables.

## 📁 Structure du Projet

- **src/** : Contient le code source de votre application (ex: `main.c`).
- **tools/** : Répertoire généré contenant le SDK (bibliothèques et headers) ainsi que les utilitaires de conversion.
- **bin/** : Contient l'exécutable `.BIN` après compilation.
- **output/** : Contient les images disquettes finales au format `.fd` et `.sd`.

## 🛠️ Prérequis

- **CMOC** : Le compilateur C pour processeur 6809.
- **Git** : Requis pour cloner les outils de dépendance lors de l'installation.
- **Python 3** : Requis pour le script de conversion `fd2sd.py`.
- **Python 3 / Pillow** : Requis pour le script de traitement d'image `png2mo5.py`.

## 🚀 Configuration et Compilation

### 1. Personnalisation

Ouvrez le fichier `Makefile` à la racine du projet et modifiez la variable suivante pour définir le nom de votre programme :

```makefile
PROGRAM := MYAPP
```

(Remplacez `MYAPP` par le nom souhaité.)

### 2. Installation de l'environnement

Avant de compiler pour la première fois, lancez la commande suivante pour configurer le SDK et les outils système :

```bash
make install
```

Cette commande :
- télécharge et utilise le projet **BootFloppyDisk** pour la génération des images disquettes bootables  
  👉 https://github.com/OlivierP-To8/BootFloppyDisk.git
- compile le **sdk_mo5**, basé sur le code *helper* développé pour faciliter le développement sur Thomson MO5  
  👉 https://github.com/thlg057/sdk_mo5.git
- exporte l'ensemble des fichiers nécessaires dans le dossier `tools/`

### 3. Compilation du projet

Pour générer votre programme et les images disques, utilisez simplement :

```bash
make
```

Cette action va compiler votre code source, le lier à la bibliothèque SDK et créer les fichiers de stockage dans le dossier `output/`.

## 📖 Utilisation du SDK

Le SDK **mo5_sdk** s'appuie sur le code *helper* du projet **sdk_mo5**, qui regroupe un ensemble de fonctions que j’ai développées pour simplifier et accélérer le développement sur Thomson MO5.

Pour utiliser ces fonctions dans votre code, incluez les fichiers d'en-tête exportés :

```c
#include <mo5_stdio.h>
#include <mo5_defs.h>
```

Le `Makefile` s'occupe automatiquement d'inclure les chemins (`-Itools/include`) et de lier la bibliothèque statique (`tools/lib/libsdk_mo5.a`) lors de la compilation.

## 🎨 Conversion d'Images PNG en Sprites

Le projet inclut un script Python qui transforme une image PNG en fichier `.h` contenant la définition C du sprite correspondant.

Pour convertir une image :

```bash
make convert IMG=./assets/sprite.png
```

Cette commande :
- Analyse l'image PNG et détecte automatiquement les couleurs (2 couleurs par groupe de 8 pixels)
- Génère automatiquement le fichier `include/assets/sprite1.h` avec la définition du sprite
- Crée les répertoires nécessaires si besoin
- Préserve la structure de dossiers (ex: `./assets/perso/hero.png` → `./include/assets/perso/hero.h`)

Le fichier généré contient :
- Les données de **FORME** (bitmap 1 bit/pixel)
- Les données de **COULEUR** (attributs par groupe de 8 pixels)
- Les commentaires avec visualisation ASCII du sprite

Vous pouvez ensuite inclure le fichier généré dans votre code :

```c
#include "assets/sprite1.h"
```

## 🧹 Nettoyage

- `make clean` : Supprime les fichiers de build du projet (fichiers objets, binaires et images disques).
- `make clean-all` : Supprime tout le projet ainsi que le dossier `tools/` (SDK et outils inclus).

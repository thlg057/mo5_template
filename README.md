# 🕹️ Thomson MO5 Project Template

Ce dépôt est un modèle (template) pour le développement de logiciels et de jeux pour le **Thomson MO5** en langage C.  
Il automatise l'installation de l'environnement, la gestion du SDK et la création d'images disques bootables.

## 📁 Structure du Projet

- **src/** : Contient le code source de votre application (ex: `main.c`).
- **tools/** : Répertoire généré contenant le SDK (bibliothèques et headers) ainsi que les utilitaires de conversion.
- **bin/** : Contient l'exécutable `.BIN` après compilation.
- **output/** : Contient les images disquettes finales au format `.fd` et `.sd`.

## 🛠️ Prérequis

- **CMOC** : Le compilateur C pour processeur 6809.
- **Git** : Requis pour cloner les outils de dépendance lors de l'installation.
- **Python 3 / Pillow** : Requis pour les scripts de conversion (`fd2sd.py` et `png2mo5.py`).

### 📦 Installation sur GitHub Codespaces

Si vous utilisez GitHub Codespaces, vous pouvez installer automatiquement tous les prérequis avec :

```bash
make setup-codespace
```

Cette commande installe :
- **flex** (requis pour lwtools)
- **Pillow** (bibliothèque Python pour la conversion d'images)
- **lwtools** (assembleur 6809)
- **CMOC** (compilateur C pour 6809)
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
- télécharge et compile le **sdk_mo5**, sdk permettant de faciliter le développement sur Thomson MO5. Le sdk inclus aussi des scripts python permettant de générer les fichiers disquettes du type fd et sd (compatible avec SDDrive)
  👉 https://github.com/thlg057/sdk_mo5.git
- exporte l'ensemble des fichiers nécessaires dans le dossier `tools/`

### 3. Compilation du projet

Pour générer votre programme et les images disques, utilisez simplement :

```bash
make
```

Cette action va compiler votre code source, le lier à la bibliothèque SDK et créer les images disquette (.fd et .sd) dans le dossier `output/`.

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

## MO5 MCP Server (RAG & Build Toolchain)

Ce serveur MCP (Model Context Protocol) est le pont entre les agents IA modernes (Claude Desktop, Augment, Cursor) et l'univers du Thomson MO5.  
Il permet de consulter une base de connaissances experte et de manipuler les fichiers du patrimoine MO5.

### 🏗️ L'Écosystème de Développement MO5

Ce serveur fait partie d'une suite d'outils complète pour le développement moderne sur 6809 :

- **SDK MO5** : https://github.com/thlg057/sdk_mo5  
  Librairie C optimisée pour CMOC.
- **MO5 Project Template** : https://github.com/thlg057/mo5_template  
  Canevas de projet avec Makefile automatisé.
- **Ce Serveur MCP** : L'assistant qui fait le lien, répond aux questions techniques et génère les assets.

### 🌐 Infrastructure RAG (Intelligence Artificielle)

Le serveur s'appuie sur une architecture de Retrieval-Augmented Generation pour fournir des réponses précises basées sur la documentation technique réelle.

#### Instance Publique (Recommandée)

Le service est déployé publiquement pour la communauté : https://retrocomputing-ai.cloud/

### 🤖 Configuration de l'Assistant IA (MCP)

Ce projet supporte le **Model Context Protocol (MCP)**, vous permettant d'utiliser Claude, Augment ou Cursor comme un expert Thomson MO5 capable de compiler votre code et de manipuler vos images disquettes.

#### 1. Installation automatique

Le projet inclut une automatisation pour configurer votre environnement en une seule commande :

```bash
make install-mcp
```

Cette commande va :

- Cloner ou mettre à jour le serveur MCP dans votre dossier `tools/`.
- Installer les dépendances Node.js nécessaires.
- Générer vos fichiers de configuration personnalisés avec les chemins absolus vers votre projet actuel.

#### 2. Activation dans votre Agent

Une fois l'installation terminée, vous devez indiquer à votre agent où trouver le serveur.

👉 Suivez le guide détaillé : `MCP_SETUP.md` (`./MCP_SETUP.md`) pour finaliser l'intégration en quelques clics.


### 📂 Structure du Projet

- `index.js` : Logique du serveur MCP (Node.js).
- `scripts/` : Moteur de conversion Python (`makefd.py`, `fd2sd.py`, `png2mo5.py`).
- `package.json` : Dépendances et métadonnées npm.
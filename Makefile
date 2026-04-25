# ==========================================================
# Projet Thomson MO5 - Build & SDK Management
# ==========================================================

PROGRAM      := MYAPP

# Version du SDK compatible avec ce projet (format MAJEUR.MINEUR.x)
SDK_COMPAT_VERSION := 1.3

# Chemins des outils externes
TOOLS_DIR    := $(CURDIR)/tools
SDK_DIR      := $(TOOLS_DIR)/sdk_mo5
MCP_DIR      := $(TOOLS_DIR)/mcp_mo5
VSCODE_DIR   := $(CURDIR)/.vscode
AI_CFG_DIR   := $(CURDIR)/.mcp-templates


# Répertoires du projet
SRC_DIR      := src
BIN_DIR      := bin
OUTPUT_DIR   := output
INCLUDE_DIR  := include

# Fichiers cibles
PROGRAM_BIN  := $(BIN_DIR)/$(PROGRAM).BIN
DISK_IMAGE   := $(OUTPUT_DIR)/$(PROGRAM).fd
DISK_IMAGE_SD:= $(OUTPUT_DIR)/$(PROGRAM).sd

# Variables pour les dépôts
REPO_SDK     := https://github.com/thlg057/sdk_mo5.git
REPO_MCP     := https://github.com/thlg057/mo5-mcp-server.git
LWTOOLS_URL  := https://github.com/thlg057/retro-toolchain-cache/releases/download/v1/lwtools-4.24.tar.gz
CMOC_URL     := https://github.com/thlg057/retro-toolchain-cache/releases/download/v1/cmoc-0.1.97.tar.gz

# Paramètres du compilateur (Intégration du SDK)
CMOC         := cmoc
SDK_INC      := -I$(TOOLS_DIR)/include
SDK_LIB      := $(TOOLS_DIR)/lib/libsdk_mo5.a
CMOC_FLAGS   := --thommo --org=2600 -Wno-assign-in-condition $(SDK_INC) -I$(INCLUDE_DIR)

FD2SD        := python3 $(TOOLS_DIR)/scripts/fd2sd.py
PNG2MO5      := python3 $(TOOLS_DIR)/scripts/png2mo5.py
MAKEFD       := python3 $(TOOLS_DIR)/scripts/makefd.py

# Options additionnelles pour le convertisseur (ex: --transparent)
CONVERT_OPTS ?=

# Fichiers sources du projet
# A compléter avec vos .c et .h
PROJ_SRC     := $(SRC_DIR)/main.c
PROJ_HDR     := 

# ==========================================================
# TARGETS
# ==========================================================

.PHONY: all clean install install-sdk install-bootfd clean-all convert setup-codespace

# Cible par défaut : construit l'image SD
all: $(DISK_IMAGE_SD)

# --- COMPILATION DU PROJET ---

# Compilation du binaire avec liaison à la bibliothèque SDK
$(PROGRAM_BIN): $(PROJ_SRC) $(PROJ_HDR) $(SDK_LIB)
	@mkdir -p $(BIN_DIR)
	@echo "Compilation du projet avec le SDK..."
	$(CMOC) $(CMOC_FLAGS) -o $@ $(PROJ_SRC) $(SDK_LIB)
	@echo "✓ Binaire prêt : $@"

# Création de l'image de disquette .fd
$(DISK_IMAGE): $(PROGRAM_BIN)
	@mkdir -p $(OUTPUT_DIR)
	@echo "Génération de l'image disquette .fd..."
	@$(MAKEFD) $@ $(PROGRAM_BIN)
	@echo "✓ Image .fd prête : $@"

# Conversion .fd vers .sd
$(DISK_IMAGE_SD): $(DISK_IMAGE)
	@echo "Conversion .fd vers .sd..."
	@$(FD2SD) -conv $(DISK_IMAGE) $(DISK_IMAGE_SD)
	@echo "✓ Image .sd prête : $@"

# --- GESTION DE L'INSTALLATION (SDK & TOOLS) ---

install: install-sdk

install-sdk:
	@echo "--- Gestion du SDK MO5 (compatible v$(SDK_COMPAT_VERSION).x) ---"
	@mkdir -p "$(INCLUDE_DIR)"
	@mkdir -p "$(TOOLS_DIR)"
	@if [ ! -d "$(SDK_DIR)" ]; then \
		git clone $(REPO_SDK) "$(SDK_DIR)"; \
	else \
		cd "$(SDK_DIR)" && git fetch --tags; \
	fi
	@echo "--- Recherche du dernier tag compatible v$(SDK_COMPAT_VERSION).x ---"
	@cd "$(SDK_DIR)" && \
		LATEST_TAG=$$(git tag --list "v$(SDK_COMPAT_VERSION).*" | sort -V | tail -n1); \
		if [ -z "$$LATEST_TAG" ]; then \
			echo "⚠ Aucun tag v$(SDK_COMPAT_VERSION).x trouvé, utilisation de la branche principale."; \
		else \
			echo "→ Checkout $$LATEST_TAG"; \
			git checkout $$LATEST_TAG; \
		fi
	@echo "--- Build et Export vers $(TOOLS_DIR) ---"
	$(MAKE) export_sdk DIST_DIR="$(TOOLS_DIR)" -C "$(SDK_DIR)"
	rm -rf $(SDK_DIR)
	@echo "✓ SDK installé et exporté."

# --- NETTOYAGE ---

clean:
	@rm -rf $(BIN_DIR) $(OUTPUT_DIR)
	@echo "✓ Nettoyage du projet terminé"

clean-all: clean
	@rm -rf $(TOOLS_DIR)
	@echo "✓ Tout a été supprimé (Projet + Outils)"

# --- CONVERSION D'IMAGES PNG VERS .H ---

convert:
	@if [ -z "$(IMG)" ]; then \
		echo "Usage: make convert IMG=./assets/sprite.png"; \
		exit 1; \
	fi
	$(eval HEADERFILE := $(INCLUDE_DIR)/$(IMG:.png=.h))
	@mkdir -p $(INCLUDE_DIR)
	@mkdir -p $(dir $(HEADERFILE))
	$(PNG2MO5) $(IMG) --name $(HEADERFILE) $(CONVERT_OPTS) --quiet
	@echo "✓ Image convertie : $(HEADERFILE)"

# --- CONFIGURATION CODESPACE ---

setup-codespace:
	@echo "=========================================="
	@echo "Installation des prérequis pour Codespace"
	@echo "=========================================="
	@echo ""
	@echo "→ Mise à jour des paquets..."
	-sudo apt update
	@echo ""
	@echo "→ Installation de flex..."
	sudo apt install -y flex
	@echo ""
	@echo "→ Installation de Pillow (Python)..."
	pip install Pillow
	@echo ""
	@echo "→ Téléchargement et installation de lwtools..."
	wget -q $(LWTOOLS_URL)
	tar -xzf lwtools-4.24.tar.gz
	rm lwtools-4.24.tar.gz
	cd lwtools-4.24 && make && sudo make install && cd ..
	rm -rf lwtools-4.24
	@echo ""
	@echo "→ Téléchargement et installation de CMOC..."
	wget -q $(CMOC_URL)
	tar -xzf cmoc-0.1.97.tar.gz
	rm cmoc-0.1.97.tar.gz
	cd cmoc-0.1.97 && ./configure && make && sudo make install && cd ..
	rm -rf cmoc-0.1.97
	@echo ""
	@echo "=========================================="
	@echo "✓ Configuration Codespace terminée !"
	@echo "=========================================="
	@echo ""
	@echo "Vous pouvez maintenant exécuter:"
	@echo "  make install    # Pour installer le SDK"
	@echo "  make            # Pour compiler le projet"
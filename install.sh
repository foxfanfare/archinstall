#!/bin/bash

# ------------------------------------------------
# SCRIPT D'INSTALLATION DE ARCH LINUX
# ------------------------------------------------

# /!\ ATTENTION /!\
# ------------------------------------------------

# Dans le cadre de SILENCIO-4570S, au lancement de l'installateur,
# presser 'e' pour éditer 'Arch Linux install medium (x86_64, UEFI)'.
# À la fin de la ligne commencant par 'linux' et juste avant celle
# commencant par 'initrd', ajouter 'nomodeset' à la fin.
# Presser Ctrl-x pour lancer l'ISO.

# ------------------------------------------------
# Une fois dans la console, pour lancer le script
# ------------------------------------------------

# loadkeys fr-latin1
# pacman -Sy git
# git clone https://github.com/foxfanfare/archinstall
# sh archinstall/install.sh

# ------------------------------------------------
# LANCEMENT DE L'INTERFACE
# ------------------------------------------------

# Titre
clear
echo
echo -e " ================================================= "
echo -e " SCRIPT D'INSTALLATION DE ARCH LINUX (RÉMY MARTIN) "
echo -e " ================================================= "
echo
echo -e " Important : Veuillez vous connecter à internet par le port ethernet"
echo

# Nom de l'hôte
echo -n " Nom d'hôte : "
read HOSTNAME
: "${HOSTNAME:?"Le nom d'hôte ne peut pas être vide."}"

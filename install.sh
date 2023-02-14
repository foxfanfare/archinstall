#!/usr/bin/env bash

# ------------------------------------------------
# SCRIPT D'INSTALLATION DE ARCH LINUX
# ------------------------------------------------
#
# INSTALLATION
# ------------------------------------------------
# Dans le cadre de SILENCIO-4570S, au lancement de l'installateur,
# presser 'e' pour éditer 'Arch Linux install medium (x86_64, UEFI)'.
# À la fin de la ligne commencant par 'linux' et juste avant celle
# commencant par 'initrd', ajouter 'nomodeset' à la fin.
# Presser Ctrl-x pour lancer l'ISO.
#
# LANCEMENT DU SCRIPT
# ------------------------------------------------
# loadkeys fr-latin1
# pacman -Sy git
# git clone https://github.com/foxfanfare/archinstall
# sh archinstall/install.sh

# Page de titre
# ------------------------------------------------
print_title() {
  BOLD=$(tput bold)
  NORMAL=$(tput sgr0)
  DELIMITER="-----------------------------------------"
  SPACE="      - "
  TOTAL="6"
  clear
  echo "${BOLD} --------------------------------------- "
  echo "| SCRIPT D'INSTALLATION POUR ARCH LINUX |"
  echo "| v.2023-02-14                          |"
  echo " --------------------------------------- "
  echo
  echo "IMPORTANT : Veuillez vous connecter à internet par le port ethernet.${NORMAL}"
  read -p "Presser une touche pour continuer..."
}

# Choix du profil
# ------------------------------------------------
select_profile() {
  PROFILES=(
    "Silencio-4570S"
    "HP-DV7"
  )

  echo $DELIMITER
  echo "${BOLD}:: Choisir le support d'installation :${NORMAL}"

  PS3=""
  select PROFILE in "${PROFILES[@]}";
    do case "$PROFILE" in
      "${PROFILES[0]}")
        break;;
      "${PROFILES[1]}")
        break;;
      *)
        echo -e ""$BOLD"ERREUR : Choix invalide. Veuillez recommencer...$NORMAL" ;;
    esac;
  done;
}

# Confirmation du profil
# ------------------------------------------------
confirm_profile() {
  read -p "${BOLD}:: Procéder à l'installation pour "$PROFILE" ? Des données risques d'être effacées.${NORMAL}[o/N] " CONFIRM;
  if [[ "$CONFIRM" =~ ^([oO][uU][iI]|[oO])$ ]]; then
    break
  else
    exit
  fi
}

# Choisir le mot de passe
# ------------------------------------------------
choose_password() {
  echo $DELIMITER
  echo -n "Choisir le mot de passe : "
  read -s PASSWORD;
  echo
  echo -n "Répéter le mot de passe : "
  read -s PASSWORD2;
  echo
  if [[ "$PASSWORD" != "$PASSWORD2" ]]; then
    echo "${BOLD}ERREUR : Les mots de passe ne sont pas identiques.${NORMAL}"
    read -p "Presser une touche pour recommencer...";
    sh install.sh;
  fi
}

# Partitionnement des disques
# ------------------------------------------------
format() {
  clear
  echo $DELIMITER
  echo "${BOLD}Installation système pour $PROFILE${NORMAL}"
  echo $DELIMITER
  echo
  echo "${BOLD}(1/${TOTAL}) Gestion des disques${NORMAL}"
  echo "${SPACE}Partitionnement des disques"
  umount -R /mnt &>/dev/null;
  swapoff /dev/sda2 &>/dev/null;
  printf "d\n\nd\n\nd\n\n
    \nn\n\n2\n\n+1G
    \nn\n\n1\n\n+10G
    \nn\n\n3\n\n
    \nw\n" | fdisk /dev/sda &>/dev/null
  echo
}

# Lancement du script
# ------------------------------------------------
print_title;
select_profile;
echo
confirm_profile;
choose_password;
format;

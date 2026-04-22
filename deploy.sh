#!/bin/bash
# PORA — Propre ou Rien Auto — FTP Deploy Hostinger
# Usage:
#   bash deploy.sh             # upload HTML + config + logos (pas les gros assets image)
#   bash deploy.sh --all       # tout uploader (HTML + assets complets)
#   bash deploy.sh file.html   # upload un fichier spécifique

# ==== À COMPLÉTER PAR NATHAN / ARNAUD APRÈS ACHAT HOSTING ====
FTP_HOST="propreourienauto.fr"
FTP_USER="FTP_USER_TO_REPLACE"
FTP_PASS="FTP_PASS_TO_REPLACE"
SITE_URL="https://propreourienauto.fr"
# ================================================================

DIR="$(cd "$(dirname "$0")" && pwd)"

upload() {
  local file="$1"
  local remote="$2"
  curl -T "$file" "ftp://$FTP_HOST/$remote" --user "$FTP_USER:$FTP_PASS" --ftp-create-dirs -s
  if [ $? -eq 0 ]; then
    echo "  ✓ $remote"
  else
    echo "  ✗ FAILED: $remote"
  fi
}

echo "=== PORA Deploy ==="

if [ "$1" = "--all" ]; then
  echo "[1/5] HTML & config..."
  for f in index.html services.html tarifs.html realisations.html a-propos.html contact.html mentions-legales.html 404.html sitemap.xml robots.txt .htaccess; do
    [ -f "$DIR/$f" ] && upload "$DIR/$f" "$f"
  done

  echo "[2/5] CSS & JS..."
  for f in "$DIR"/assets/css/*.css "$DIR"/assets/js/*.js; do
    [ -f "$f" ] && upload "$f" "assets/${f#$DIR/assets/}"
  done

  echo "[3/5] Logos..."
  for f in "$DIR"/assets/logo/*; do
    [ -f "$f" ] && upload "$f" "assets/logo/$(basename "$f")"
  done

  echo "[4/5] Favicons..."
  for f in "$DIR"/assets/favicon/*; do
    [ -f "$f" ] && upload "$f" "assets/favicon/$(basename "$f")"
  done

  echo "[5/5] Images hero & contenu..."
  for f in "$DIR"/assets/img/*; do
    [ -f "$f" ] && upload "$f" "assets/img/$(basename "$f")"
  done

elif [ -n "$1" ]; then
  echo "Upload fichier unique: $1"
  upload "$DIR/$1" "$1"

else
  echo "[1/3] HTML & config..."
  for f in index.html services.html tarifs.html realisations.html a-propos.html contact.html mentions-legales.html 404.html sitemap.xml robots.txt .htaccess; do
    [ -f "$DIR/$f" ] && upload "$DIR/$f" "$f"
  done

  echo "[2/3] CSS & JS..."
  for f in "$DIR"/assets/css/*.css "$DIR"/assets/js/*.js; do
    [ -f "$f" ] && upload "$f" "assets/${f#$DIR/assets/}"
  done

  echo "[3/3] Logos critiques..."
  for f in "$DIR"/assets/logo/logo-light.png "$DIR"/assets/logo/logo-dark.png "$DIR"/assets/favicon/favicon.ico; do
    [ -f "$f" ] && upload "$f" "${f#$DIR/}"
  done

  echo ""
  echo "Note : pour inclure les images hero et les favicons complets, relancer avec --all."
fi

echo ""
echo "=== Deploy terminé ==="
echo "Vérifier : $SITE_URL"

#!/bin/bash

NUMEROETUDIANT=e22000229

while getopts ":l" opt; do
  case ${opt} in
    l )
      CREATE_LINK=true
      ;;
    \? )
      echo -e "Usage: save.sh [-l] version\nl: spécifie si le script doit recréer le lien de prod vers la version sauvegardé"
      exit 1
      ;;
  esac
done

shift $((OPTIND - 1))

if [ $# -ne 1 ]; then
  echo -e "Usage: save.sh [-l] version\nl: spécifie si le script doit recréer le lien de prod vers la version sauvegardé"
  exit 1
fi

VERSION=$1
IFS='.' read -ra VERSION_ARRAY <<< "$VERSION"
X=${VERSION_ARRAY[0]}
Y=${VERSION_ARRAY[1]}

DIRECTORY="/home/2023DIFAL3/${NUMEROETUDIANT}/public_html/v${X}_${Y}"

# Supprimer le répertoire existant
rm -rf "$DIRECTORY" >> /dev/null

# Copier les fichiers
if [ "$Y" -eq 0 ]; then
  cp -r "/home/2023DIFAL3/${NUMEROETUDIANT}/public_html/v${X}" "$DIRECTORY"
else
  cp -r "/home/2023DIFAL3/${NUMEROETUDIANT}/public_html/v${X}.${Y}" "/home/2023DIFAL3/${NUMEROETUDIANT}/public_html/v${X}_${Y}"
fi

# Changer les permissions
chmod -R 775 "$DIRECTORY"

# Supprimer le lien symbolique et recréer si nécessaire
if [ "$CREATE_LINK" ]; then
  rm /home/2023DIFAL3/${NUMEROETUDIANT}/public_html/prod >> /dev/null
  ln -s "$DIRECTORY" /home/2023DIFAL3/${NUMEROETUDIANT}/public_html/prod
fi

echo "Script exécuté avec succès!"
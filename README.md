# Makefile pour scrapper le générateur d'attestation

Ce Makefile est un peu débile.
Il permet de récupérer en local et donc de "prouver" que le code js de https://media.interieur.gouv.fr/deplacement-covid-19/ génère bien le formulaire et le QR complétement coté client.
Pour que ça marche vraiment en local ("file:///"), il faut se passer du fetch qui récupére le template du PDF d'où le patch_fetch.js.

La commande suivante :
```
make
```
va donc récupérer les fichiers nécessaires, vous demander vos coordonnés (histoire de les avoirs pre-rentré dans le formulaire) et va ouvrir le dit formulaire dans un navigateur

# Dépendance

Les commandes suivantes sont nécessaires: make, curl, envsubst, browse

Sur ubuntu:
```
sudo apt install curl gettext-base xdg-utils make
```

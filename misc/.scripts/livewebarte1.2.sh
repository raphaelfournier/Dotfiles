#!/bin/bash
# Script pour récupérer les vidéos FLV du site liveweb.arte.tv
# par Carmelo Ingrao <carmelo42@gmail.com> http://c.ingrao.free.fr/code/
# version 1.0
# release date 21 février 2010
## modified by Fitzcarraldo 24 April 2013
## version 1.2
## release date 24 April 2013
# licence : GPLv2
# rtmpdump compilé doit être dans le même répertoire que le script
## rtmpdump must be installed and in user's $PATH (e.g. I have it in /usr/bin/)
# utilisation du script :
#
# ./script.sh url fichier.flv
# _______________
 
# url --> $1
# fichier --> $2
 
# fichier de sortie
# on efface l'écran avant de commencer
clear
 
# on affiche les infos sur le script
echo "livewebarte.sh version 1.0."
echo "(c) 2010 Carmelo Ingrao; License : GPL"
echo "livewebarte.sh version 1.2."
echo "updated from version 1.1 by Fitzcarraldo on 24 April 2013; License : GPL"
echo "usage : ./livewebarte.sh url_concert_sur_liveweb.arte.tv fichier.flv"
echo "rtmpdump must be installed and in your path."
 
# on télécharge le code source de la page streamant le concert dans le fichier sourceconcert.html
wget $1 -O sourceconcert.html
 
# on récupère le numéro d'event et on le copie dans eventok.txt
#cat sourceconcert.html | grep "new LwEvent" > event.txt
#cat event.txt | cut -b "15 16 17" > eventok.txt
grep "new LwEvent" sourceconcert.html | grep -E -o -e "[0-9]+" > eventok.txt
 
# on prend le fichier XML d'arte et on crée l'url avec le bon numéro d'event
# xmloriginal="http://arte.vo.llnwd.net/o21/liveweb/events/event-610.xml"
 
# url du xml sans le numéro d'event original (pour faciliter)
xmloriginal2="http://arte.vo.llnwd.net/o21/liveweb/events/event-"
 
# on assigne à la variable b le contenu de eventok.txt --> numéro correct d'event
b=$(cat eventok.txt)
 
# on créer l'url correct du fichier XML qu'on téléchargera
xmlok=$(echo $xmloriginal2$b)
finxml=".xml"
xmlfinal=$(echo $xmlok$finxml)
 
# on télécharge le bon XML
wget $xmlfinal -O xmlok.xml
echo "Fichier XML téléchargé"
 
## I have changed the code in this part:
# on extrait le nom du fichier MP4 depuis le fichier xmlok.xml
mp4hd=$(cat xmlok.xml | grep "urlHd")
# on efface le début de l'url du MP4
# on efface le surplus à la fin du nom du MP4 et on sauve le nom dans la variable mp4hdcut2
mp4hdcut2=${mp4hd#*MP4}
mp4hdcut2=${mp4hdcut2%%mp4*}
mp4hdcut2="MP4"$mp4hdcut2"mp4"
## end of my changes to evaluate mp4hdcut2
 
# on lance la commande rtmpdump avec les paramètres
# rappel :
# $2 = nom du fichier de sortie
# $mp4hdcut2 = nom du fichier MP4
 
## Carmelo had ./rtmpdump here, but I removed the "./"
rtmpdump -r rtmp://arte.fcod.llnwd.net:1935/a2306/o25 -a a2306/o25 -f LNX 10,0,45,2 -W http://liveweb.arte.tv/flash/player.swf -t rtmp://arte.fcod.llnwd.net:1935/a2306/o25 -p http://liveweb.arte.tv/ -o $2 -y $mp4hdcut2
 
# on efface les fichiers crées
rm sourceconcert.html
#rm event.txt
rm eventok.txt
rm xmlok.xml
 
# Affichage des infos de fin
echo "________"
echo "Voilà, le téléchargement est terminé."
echo "Le fichier se trouve ici :"
echo " "
echo $2
echo " "
echo "Bon visionnage"
echo " "
echo " "
exit 0

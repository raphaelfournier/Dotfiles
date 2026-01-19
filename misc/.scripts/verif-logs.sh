#! /bin/bash
# Variables pour les logsearches d'Ivan
HOST_LOGSEARCHES="176.31.115.202"
LOGIN_LOGSEARCHES="fournier"
DIR="/home/fournier/EDKLOG/"
COMMAND_LOGSEARCHES="ls -gG $DIR | tail -n20"
COMMAND_LOGSEARCHES_VERIF="ls -gG $DIR | tail -n20| awk '{print \$5}' | cut -d \"-\" -f3 | sort -u | wc -l"

# Vérification des logsearches d'Ivan
echo -e "\n** Vérification des 20 derniers logs d'Ivan sur $HOST_LOGSEARCHES **\n"
ssh -l $LOGIN_LOGSEARCHES $HOST_LOGSEARCHES $COMMAND_LOGSEARCHES
echo -e "\n** Nombre de jours différents (20) : "
ssh -l $LOGIN_LOGSEARCHES $HOST_LOGSEARCHES $COMMAND_LOGSEARCHES_VERIF

# Variables pour les log d'accurate files
YEAR=`date +%Y`
MONTH=`date +%m`
HOST_ACCURATEFILES="woolthorpe.lip6.fr"
LOGIN_ACCURATEFILES="fournier"
COMMAND_ACCURATEFILES="ls -gG /data/fournier/DirectDownload/accuratefiles/$YEAR/$MONTH/ | cut -d \" \" -f3- | tail -n20"
# on regarde les fichiers de log, normalement tous vides
COMMAND_ACCURATEFILES_VERIF="ls -gG /data/fournier/DirectDownload/accuratefiles/$YEAR/$MONTH/log/*.parsing.log | cut -d \" \" -f3- | grep -v \"^0\""

# Vérification des accurate files
echo -e "\n** Vérification des derniers jours (max 20) sur $HOST_ACCURATEFILES **"
ssh -l $LOGIN_ACCURATEFILES $HOST_ACCURATEFILES $COMMAND_ACCURATEFILES
echo -e "\n** On regarde les logs :"
ssh -l $LOGIN_ACCURATEFILES $HOST_ACCURATEFILES $COMMAND_ACCURATEFILES_VERIF || echo "tous les fichiers de log sont vides, c'est bon !"

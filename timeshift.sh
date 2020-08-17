#!/bin/bash

LIST="Lister les backups"
CHECK="Checker si un autre backup peut être fait"
CREATE="Créer un backup"

which notify-send > /dev/null
if [ $? = 1 ]
then
	sudo apt install -y libnotify-bin
fi

which zenity > /dev/null
if [ $? = 1 ]
then
	sudo apt install -y zenity
fi

which timeshift > /dev/null
if [ $? = 1 ]
then
	sudo apt install -y timeshift
fi

# Vérification que le script n'est pas lancé directement avec sudo (le script contient déjà les sudos pour les actions lorsque c'est nécessaire)
if [ "$UID" -eq "0" ]
then
    zenity --warning --height 80 --width 400 --title "EREUR" --text "Merci de lancez le script sans sudo : \n<b>./rsync.sh</b>\nVous devrez entrer le mot de passe root par la suite."
    exit
fi

CHK_REP=$(zenity --entry --width 350 --title="Backup" --text "Que voulez-vous faire ?" --entry-text="$CHECK" "$LIST" "$CREATE")
if [ $? -ne 0 ] ; then
	exit
fi

date=$(date +%d-%m-%Y)
heure=$(date +%Hh%M)

chkDef() {
	case "$CHK_REP" in
		"$CHECK") sudo timeshift --list && sudo timeshift --check && notify-send -i dialog-ok "Timeshift" "Terminée avec succès le $date à $heure" -t 2000 && sudo timeshift --list && exit 0 || zenity --warning --height 80 --width 400 --title "EREUR" --text "Il y a eu une erreur de synchronisation des dossiers. Veuillez démonter la partition et recommencer." && sudo timeshift --list && exit 1;;
		"$CREATE") sudo timeshift --list && sudo timeshift --create --comments "on demand" --tags D && notify-send -i dialog-ok "Timeshift" "Terminée avec succès le $date à $heure" -t 2000 && sudo timeshift --list && exit 0 || zenity --warning --height 80 --width 400 --title "EREUR" --text "Il y a eu une erreur de synchronisation des dossiers. Veuillez démonter la partition et recommencer." && sudo timeshift --list && exit 1;;

		"$LIST") sudo timeshift --list;;
	esac
}

chkDef



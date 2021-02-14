# linux-timeshift

![Creative Commons](cc.png)

Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)

<p>Un script shell qui permet de faire une sauvegarde grâce à l'application timeshift. Pas besoin de lancer l'application, juste de lancer le script pour vérifier si un backup peut être fait ou simplement pour réaliser un nouveau backup. Vous remarquerez que les nouveaux backups auront comme tag 'hourly', ce qui permet de supprimer automatiquement les plus anciens. 
Les paquets utiles seront installés automatiquement s'ils ne le sont pas.</p>

Pour lancer le script, ne pas oublier d'autoriser l'exécution : <br/>`chmod +x ./timeshift.sh`

Puis se placer dans le dossier et exécuter le script : <br/>`./timeshift.sh`

Et voilà, après tout se fait tout seul.

---

<p>A shell script that allows to make a backup thanks to the timeshift application. No need to launch the application, just run the script to check if a backup can be done or simply to make a new backup. You'll notice that new backups will be tagged 'hourly', which allows you to automatically delete the oldest ones. 
Useful packages will be installed automatically if they are not.</p>

To launch the script, don't forget to allow execution: <br/>`chmod +x ./timeshift.sh`

Then go into the folder and execute the script: <br/>`./timeshift.sh`

There you go, after all, it's all self-made.

``` bash
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

```

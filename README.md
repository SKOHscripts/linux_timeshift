# linux-timeshift
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
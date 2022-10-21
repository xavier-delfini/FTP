s="sudo"
$s apt install proftpd-* openssl

echo "Création du groupe ftp"
$s groupadd ftp
echo "Ajout de l'utilisateur Merry et Ajout au groupe ftp"
$s useradd -m Merry && $s adduser Merry ftp
$s echo "Merry:kalimac" | $s chpasswd 

echo "Ajout de l'utilisateur Pippin et Ajout au groupe ftp"
$s useradd -m Pippin && $s adduser Pippin ftp
$s echo "Pippin:secondbreakfast" | $s chpasswd
 
echo "Génération des clefs de chiffrement"
$s mkdir /etc/proftpd/ssl
$s openssl req -new -x509 -keyout /etc/proftpd/ssl/proftpd.key.pem -days 365 -nodes -out /etc/proftpd/ssl/proftpd.cert.pem

echo "Sauvegarde de l'ancien fichier proftpd.conf "
$s cp /etc/proftpd/proftpd.conf /etc/proftpd/proftpd.conf.bak

echo "Remplacement du fichier proftpd.conf"

$s cp proftpd.conf /etc/proftpd/proftpd.conf
$s chmod 600 /etc/proftpd/ssl/proftpd.* 

echo "Redémarage du service proftpd"
$s systemctl restart proftpd.service

echo "Installation terminée"

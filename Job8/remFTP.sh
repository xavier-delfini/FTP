sudo gpasswd --delete Pippin ftp
sudo gpasswd --delete Merry ftp
sudo systemctl stop proftpd.service
sudo apt-get autoremove --purge proftpd* openssl

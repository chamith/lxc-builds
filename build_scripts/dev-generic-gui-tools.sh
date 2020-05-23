#! /bin/bash

DOCKER_VERSION=5:18.09.9~3-0~ubuntu-bionic
GRADLE_VERSION=5.4.1

rm /var/lib/apt/lists/lock
rm /var/cache/apt/archives/lock
rm /var/lib/dpkg/lock
rm /var/lib/dpkg/lock-frontend

echo "Updating APT"
apt update

apt install -y libnotify4 libnss3 libxkbfile1 libsecret-1-0 libgtk-3-0 libxss1
wget -O vscode.deb https://go.microsoft.com/fwlink/?LinkID=760868
dpkg -i vscode.deb

wget https://dl.pstmn.io/download/latest/linux64 -O postman.tar.gz
tar -xf postman.tar.gz -C /opt
rm postman.tar.gz
ln -s /opt/Postman/app/Postman /usr/bin/postman

apt install -y chromium-browser 
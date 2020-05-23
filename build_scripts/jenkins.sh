#! /bin/bash

DOCKER_VERSION=5:18.09.9~3-0~ubuntu-bionic
GRADLE_VERSION=5.4.1

apt install -y openjdk-11-jre unzip

wget https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip
mkdir /opt/gradle
unzip -d /opt/gradle/ gradle-$GRADLE_VERSION-bin.zip
ln -s /opt/gradle/gradle-$GRADLE_VERSION/bin/gradle /usr/bin/

apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt install -y docker-ce=$DOCKER_VERSION

curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl

usermod -aG docker jenkins

wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
apt update
apt install -y jenkins

sleep 5

systemctl start jenkins

sleep 5

systemctl status jenkins

ufw allow 8080
cat /var/lib/jenkins/secrets/initialAdminPassword

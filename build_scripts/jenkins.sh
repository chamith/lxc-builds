#! /bin/bash

DOCKER_VERSION=5:18.09.9~3-0~ubuntu-bionic
GRADLE_VERSION=7.4.1
JRE_VERSION=17

apt update
apt install -y curl openjdk-$JRE_VERSION-jre unzip wget fontconfig openjdk-11-jre ufw ca-certificates curl gnupg lsb-release
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | tee \
    /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian-stable binary/ | tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null

curl -fsSL https://download.docker.com/linux/ubuntu/gpg |  gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt update
apt install -y jenkins docker-ce docker-ce-cli containerd.io

wget https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip
mkdir /opt/gradle
unzip -d /opt/gradle/ gradle-$GRADLE_VERSION-bin.zip
ln -s /opt/gradle/gradle-$GRADLE_VERSION/bin/gradle /usr/bin/

curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl

usermod -aG docker jenkins

sleep 5

systemctl start jenkins

sleep 5

systemctl status jenkins

ufw allow 8080
cat /var/lib/jenkins/secrets/initialAdminPassword

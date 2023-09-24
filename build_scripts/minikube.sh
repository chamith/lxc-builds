NONROOT_USER=ubuntu
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
sudo dpkg -i minikube_latest_amd64.deb

echo 'alias kubectl="minikube kubectl --"' >> /home/$NONROOT_USER/.bashrc

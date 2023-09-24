NONROOT_USER=ubuntu
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install fonts-liberation libu2f-udev -y
sudo dpkg -i google-chrome-stable_current_amd64.deb
echo 'alias chrome=google-chrome' >> /home/$NONROOT_USER/.bashrc
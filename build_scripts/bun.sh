NONROOT_USER=ubuntu
curl -fsSL https://bun.sh/install | bash

echo "setting up path"
echo 'export PATH=/root/.bun/bin:$PATH' >> /home/$NONROOT_USER/.bashrc

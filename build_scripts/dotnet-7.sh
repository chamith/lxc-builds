NONROOT_USER=ubuntu

wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
chmod +x ./dotnet-install.sh
./dotnet-install.sh --channel 7.0
echo "export DOTNET_ROOT=$HOME/.dotnet" >> /home/$NONROOT_USER/.bashrc
echo "export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools" >> /home/$NONROOT_USER/.bashrc
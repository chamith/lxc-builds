wget https://dl.pstmn.io/download/latest/linux64 -O postman.tar.gz
tar -xf postman.tar.gz -C /opt
rm postman.tar.gz
ln -s /opt/Postman/app/Postman /usr/bin/postman
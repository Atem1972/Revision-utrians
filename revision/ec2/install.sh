#!/bin/bash
sudo yum update -y
#sudo groupadd docker
#sudo useradd jonh -aG docker
#sudo yum install git unzip wget httpd -y
#sudo systemctl start httpd
sudo systemctl enable httpd
sudo mkdir opt
    cd /opt
# wget https://github.com/kserge2001/web-consulting/archive/refs/heads/dev.zip
 unzip dev.zip
 cp -r /opt/web-consulting-dev/* /var/www/html

 if ! wget https://github.com/kserge2001/web-consulting/archive/refs/heads/dev.zip; then
    echo "Failed to download the zip file"
    exit 1
fi
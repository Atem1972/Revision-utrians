#!/bin/bash

# Set mysql config variables
db_username="oracle"
db_user_password="school1"
db_name="webserver"

# Log setup
LOGFILE="/var/log/setup_wordpress.log"
exec > >(tee -a $LOGFILE) 2>&1

# Update the server
sudo yum update -y

# Install Apache, MariaDB, PHP, and required packages
sudo yum install httpd mariadb-server wget -y
sudo amazon-linux-extras install epel -y
sudo amazon-linux-extras enable php7.4
sudo yum clean metadata
sudo yum install php php-cli php-pdo php-fpm php-json php-mysqlnd php-common php-mbstring php-xml -y

# Set up swap file
sudo dd if=/dev/zero of=/swapfile bs=1M count=1024
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo '/swapfile swap swap defaults 0 0' | sudo tee -a /etc/fstab

# Start and enable services
sudo systemctl start httpd mariadb
sudo systemctl enable httpd mariadb

# Set permissions for /var/www
usermod -a -G apache ec2-user
sudo chown -R ec2-user:apache /var/www
find /var/www -type d -exec chmod 2755 {} +
find /var/www -type f -exec chmod 0644 {} +

# Download and set up WordPress
wget http://wordpress.org/wordpress-5.1.1.tar.gz
tar -xzvf wordpress-5.1.1.tar.gz
rm -f wordpress-5.1.1.tar.gz
cp -r wordpress/* /var/www/html/
rm -rf wordpress

# Set up MySQL
mysql -u root <<EOF
CREATE DATABASE $db_name;
CREATE USER '$db_username'@'localhost' IDENTIFIED BY '$db_user_password';
GRANT ALL PRIVILEGES ON $db_name.* TO '$db_username'@'localhost';
FLUSH PRIVILEGES;
EOF

# Configure WordPress
cd /var/www/html
cp wp-config-sample.php wp-config.php
sed -i "s/database_name_here/$db_name/g" wp-config.php
sed -i "s/username_here/$db_username/g" wp-config.php
sed -i "s/password_here/$db_user_password/g" wp-config.php

cat <<EOF >>wp-config.php
define( 'FS_METHOD', 'direct' );
define( 'WP_MEMORY_LIMIT', '256M' );
EOF

# Restart services
sudo systemctl restart httpd mariadb

# Configure Firewall
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload

echo "WordPress setup completed. Check the log at $LOGFILE."

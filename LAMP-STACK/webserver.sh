#!/bin/bash

# Update package manager and install necessary packages
sudo yum update -y
sudo yum install -y httpd php php-mysqlnd unzip wget

# Start and enable Apache
sudo systemctl start httpd
sudo systemctl enable httpd

### Download and extract the application
wget https://github.com/kserge2001/web-consulting/archive/refs/heads/dev.zip -O /tmp/dev.zip
unzip /tmp/dev.zip -d /tmp

sudo cp -r /tmp/web-consulting-dev/* /var/www/html

# Set up a simple PHP info page
echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/info.php

# Set proper permissions for the web root
sudo chown -R apache:apache /var/www/html
sudo chmod -R 755 /var/www/html

# Restart Apache to apply changes
sudo systemctl restart httpd

# Print completion message
echo "Web server setup complete. Visit the server's public IP to verify."






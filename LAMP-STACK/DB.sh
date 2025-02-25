#!/bin/bash
# Update package manager and install MariaDB server
sudo yum update -y
sudo yum install -y mariadb-server

# Start and enable MariaDB service
sudo systemctl start mariadb
sudo systemctl enable mariadb

# Define root password and database credentials
ROOT_PASSWORD="barron"
DB_NAME="lampdb"
DB_USER="lampuser"
DB_PASSWORD="valery"

# Secure MariaDB installation non-interactively
sudo mysql -e "UPDATE mysql.user SET Password=PASSWORD('${ROOT_PASSWORD}') WHERE User='root';"
sudo mysql -e "DELETE FROM mysql.user WHERE User='';"
sudo mysql -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Create database and user
sudo mysql -u root -p"${ROOT_PASSWORD}" -e "
CREATE DATABASE ${DB_NAME};
CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
"

# Allow remote access by modifying the bind address
sudo sed -i "s/^bind-address.*/bind-address = 0.0.0.0/" /etc/my.cnf

# Restart MariaDB to apply changes
sudo systemctl restart mariadb

# Print completion message
echo "Database server setup complete. Database '${DB_NAME}' and user '${DB_USER}' created."

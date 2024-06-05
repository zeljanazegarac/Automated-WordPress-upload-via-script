#!/bin/bash

# Update packages and install NGINX, MariaDB, PHP
sudo dnf update -y
sudo dnf install nginx mariadb-server php php-fpm php-mysqlnd -y

# Start and enable services
sudo systemctl start nginx
sudo systemctl enable nginx
sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo systemctl start php-fpm
sudo systemctl enable php-fpm

# Secure MySQL installation
sudo mysql_secure_installation

# Create MySQL database and user
DB_NAME="wordpress"
DB_USER="wp_user"
DB_PASSWORD="password"

sudo mysql -e "CREATE DATABASE ${DB_NAME};"
sudo mysql -e "CREATE USER '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASSWORD}';"
sudo mysql -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Download and setup WordPress
cd /var/www/html
sudo wget https://wordpress.org/latest.tar.gz
sudo tar -xvf latest.tar.gz
sudo mv wordpress/* ./
sudo chown -R apache:apache /var/www/html
sudo chmod -R 755 /var/www/html

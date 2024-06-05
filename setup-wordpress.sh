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

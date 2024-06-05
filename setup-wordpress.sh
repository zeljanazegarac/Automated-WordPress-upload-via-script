#!/bin/bash

# Update packages and install NGINX, MariaDB, PHP
sudo dnf update -y
sudo dnf install nginx mariadb-server php php-fpm php-mysqlnd -y

#!/bin/bash

# Update packages and install NGINX, MariaDB, PHP
sudo dnf update -y
sudo dnf install nginx mariadb-server php php-fpm php-mysqlnd -y

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
sudo cp wordpress/wp-config-sample.php wordpress/wp-config.php
sudo sed -i "s/database_name_here/${DB_NAME}/" wordpress/wp-config.php
sudo sed -i "s/username_here/${DB_USER}/" wordpress/wp-config.php
sudo sed -i "s/password_here/${DB_PASSWORD}/" wordpress/wp-config.php
sudo mv wordpress/* ./
sudo chown -R apache:apache /var/www/html
sudo chmod -R 755 /var/www/html

# Configure NGINX
sudo bash -c 'cat > /etc/nginx/conf.d/wordpress.conf <<EOF
server {
    listen 80;
    server_name localhost;

    root /var/www/html;
    index index.php index.html index.htm;

    location / {
        try_files \$uri \$uri/ /index.php?\$args;
    }

    location ~ \.php\$ {
        include /etc/nginx/fastcgi_params;
        fastcgi_pass unix:/run/php-fpm/www.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    }
}
EOF'
sudo nginx -t
sudo systemctl restart nginx

echo "WordPress installation is complete. Open your browser and go to http://localhost to complete the installation."


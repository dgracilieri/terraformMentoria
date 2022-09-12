#!/bin/bash
sudo apt update
sudo apt install apache2 -y
sudo systemctl start apache2
sudo systemctl enable apache2

sudo chown www-data:www-data /var/www/html/index.html
sudo chmod 646 /var/www/html/index.html
sudo cat /etc/hostname > /var/www/html/index.html
sudo systemctl start apache2
#!/bin/bash
# script to create nginx server

apt-get update -y
apt-get install -y nginx
systemctl start nginx
systemctl enable nginx

echo "<h1>This is web page while creating specific resource</h1>" > /var/www/html/index.html

#!/bin/bash

# Update system packages
sudo apt-get update -y
sleep 5

# Install Nginx
sudo apt-get install -y nginx
sleep 5

sudo systemctl enable nginx
sleep 5

sudo systemctl start nginx
sleep 5

# Install dependencies for Terraform
sudo apt-get install -y git
sleep 5

# Update system packages
sudo apt-get update -y
sleep 5

# Create and Git clone application
mkdir application
cd application
git clone https://github.com/annkur-sharma/App01-DevOps-Facts-Blue.git

# Remove files from html folder
sudo rm -r /var/www/html/*

# Copy files to your web server root (example for Nginx /var/www/html):
sudo cp -r App01-DevOps-Facts-Blue/* /var/www/html/

# Generate a unique GUID for this VM (optional but recommended):
uuidgen | sudo tee /var/www/html/guid.txt

# Inject no-cache headers in nginx default site
if ! grep -q "location ~* \.(css|js|html)" /etc/nginx/sites-available/default; then
  sudo sed -i '/server_name _;/a \
      location ~* \.(css|js|html)$ { \
          add_header Cache-Control "no-store, no-cache, must-revalidate, proxy-revalidate, max-age=0" always; \
          add_header Pragma "no-cache" always; \
          add_header Expires "0" always; \
          expires -1; \
          etag off; \
      }' /etc/nginx/sites-available/default
fi

# Reload nginx
sudo nginx -t && sudo systemctl reload nginx
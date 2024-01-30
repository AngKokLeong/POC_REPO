#!/bin/bash

cd /tmp

apt-get update -yq
apt-get install autoconf gcc libc6 make wget unzip apache2 php libapache2-mod-php7.2 libgd-dev openssl libssl-dev openssh-server -yq

#Modify apache2 server port number
#https://opensource.com/article/22/8/automate-file-edits-sed-linux 
sed -i 's/Listen 80/Listen 12000/g' /etc/apache2/ports.conf




#Install Nagios

#Retrieve from this link 'https://www.nagios.org/downloads/nagios-core/thanks/'
wget --inet4-only --content-disposition 'https://go.nagios.org/get-core/4-5-0/' -O nagios-4.5.0.tar.gz

tar -xzvf nagios-4.5.0.tar.gz
rm nagios-4.5.0.tar.gz

cd /tmp/nagios-4.5.0

./configure --with-httpd-conf=/etc/apache2/sites-enabled

make all



# Add new user nagios
useradd nagios -mU
groupadd nagios
usermod -a -G nagios www-data



make install

make install-daemoninit

make install-commandmode

make install-config

make install-webconf


a2enmod rewrite
a2enmod cgi


ufw allow 12000/tcp
ufw reload


htpasswd -cb /usr/local/nagios/etc/htpasswd.users nagiosadmin password

ufw allow ssh

systemctl restart apache2.service
systemctl restart nagios.service
systemctl restart ssh
systemctl disable ssh
systemctl enable ssh




#Setup Nagios Plugin
cd /tmp

wget --inet4-only --content-disposition 'https://github.com/nagios-plugins/nagios-plugins/archive/refs/tags/2.4.8.tar.gz' -O nagios-plugins-2.4.8.tar.gz

tar -xzvf nagios-plugins-2.4.8.tar.gz
rm nagios-plugins-2.4.8.tar.gz

cd /tmp/nagios-plugins-2.4.8

./tools/setup

./configure

make

make install
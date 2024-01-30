#!/bin/bash

cd /home/dockeradm/Desktop

apt-get update -yq
apt-get autoconf gcc libc6 make wget unzip apache2 php libapache2-mod-php7.2 libgd-dev -yq

#Modify apache2 server port number
sed -i 's/Listen 80/Listen 12000/g' /etc/apache2/ports.conf


# Add new user nagios
useradd nagios -mU
usermod -a -G nagios www-data


#Install Nagios

#Retrieve from this link 'https://www.nagios.org/downloads/nagios-core/thanks/'
wget --inet4-only --content-disposition 'https://go.nagios.org/get-core/4-5-0/' -O nagios-4.5.0.tar.gz

tar -xzvf nagios-4.5.0.tar.gz
rm nagios-4.5.0.tar.gz

cd nagios-4.5.0

./configure --with-httpd-conf=/etc/apache2/sites-enabled

make all


#Setup Nagios Plugin
cd /home/dockeradm/Desktop

wget --inet4-only --content-disposition 'https://github.com/nagios-plugins/nagios-plugins/archive/refs/tags/2.4.8.tar.gz' -O nagios-plugins-2.4.8.tar.gz

tar -xzvf nagios-plugins-2.4.8.tar.gz
rm nagios-plugins-2.4.8.tar.gz

cd /home/dockeradm/Desktop/nagios-plugins-2.4.8

./tools/setup

./configure

make

make install
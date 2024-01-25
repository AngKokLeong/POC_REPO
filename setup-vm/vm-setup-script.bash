#!/bin/bash

apt-get update -yq

#Install packages
apt-get install net-tools autoconf gcc libc6 make wget unzip apache2 php libapache2-mod-php7.4 libgd-dev -yq

#Setup Docker Packages
/bin/bash docker-installation-script.bash -v 

#Setup Netplan to customize IP Address
cat netplan.yaml > /etc/netplan/01-network-manager-all.yaml

# Apply the netplan
netplan apply   

#Setup hostname
echo ''
cat hostname > /etc/hostname

#Setup hosts
echo ''
cat hosts > /etc/hosts

#Setup Puppet
/bin/bash puppet-setup-script.bash -v


#Setup Nagios in VM



#Setup SSH access of docker container related to Nagios

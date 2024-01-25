#!/bin/bash

apt-get update -yq

#Install packages
apt-get install net-tools  -yq

#Setup Docker Packages
/bin/bash docker-installation-script.bash -v 



#Setup hostname
echo ''
cat hostname > /etc/hostname

#Setup hosts
echo ''
cat hosts > /etc/hosts

#Setup Netplan to customize IP Address
cat netplan.yaml > /etc/netplan/01-network-manager-all.yaml

# Apply the netplan
netplan apply   

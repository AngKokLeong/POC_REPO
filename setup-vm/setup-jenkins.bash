#!/bin/bash

#This script requires sudo privilege

apt-get update -yq

wget -O /usr/share/keyrings/jenkins-keyring.asc \
    https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

apt-get update -yq
apt-get install fontconfig openjdk-17-jre -yq
apt-get install jenkins -yq


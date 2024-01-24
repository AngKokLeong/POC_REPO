#!/bin/bash


#5. Setup Puppet Server

#5.1 Download the package using wget 
# Refer to https://www.ubuntumint.com/wget-force-ipv4-ipv6-connection/
# Puppet download link retrieved from https://www.puppet.com/downloads/puppet-enterprise 
wget --content-disposition --inet4-only 'https://pm..puppet.com/cgi-bin/download.cgi?dist=ubuntu&rel=22.04&arch=amd64&ver=latest' 

#5.2 Unpack the archive
echo 'Step 4.2 Unpack the archive'

# using gunzip
echo 'Extract the archive using gunzip'
gunzip puppet-enterprise-2023.5.0-ubuntu-22.04-amd64.tar.gz

#then tar xvf
echo 'Extracting the files in tar archive'
tar xvf puppet-enterprise-2023.5.0-ubuntu-22.04-amd64.tar


# Remove the tar archive file
rm puppet-enterprise-2023.5.0-ubuntu-22.04-amd64.tar

echo 'Change working directory to puppet folder'
cd puppet-enterprise-2023.5.0-ubuntu-22.04-amd64

#5.3 Run the installer
echo 'Running the installer for Puppet Enterprise'
./puppet-enterprise-installer -y 



#5.4 Change the password
puppet infrastructure console_password --password password


#Test the puppet server with this command 'puppet agent -t'
puppet agent -t

puppet agent -t


# 6. Install puppet-bolt
wget --inet4-only --content-disposition 'https://apt.puppet.com/puppet-tools-release-bionic.deb'

dpkg --install puppet-tools-release-bionic.deb 

apt-get update -yq

apt-get install puppet-bolt -yq
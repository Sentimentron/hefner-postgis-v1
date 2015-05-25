#!/bin/bash

set -x
set -e

# Initialize the apt sources
CODENAME=`lsb_release -cs`

# Configure to use the main, multiverse etc 
echo "deb http://us.archive.ubuntu.com/ubuntu/ $CODENAME main universe multiverse" >> /etc/apt/sources.list
echo "deb http://us.archive.ubuntu.com/ubuntu/ $CODENAME-security main universe multiverse" >> /etc/apt/sources.list
echo "deb http://us.archive.ubuntu.com/ubuntu/ $CODENAME-updates main universe multiverse" >> /etc/apt/sources.list

# Standard update/upgrade
sudo apt-get update
sudo apt-get upgrade -y

# Install the base system
sudo apt-get install -y postgresql-9.4-postgis-2.1

#!/bin/bash

set -x
set -e

CODENAME=`lsb_release -cs`

# Configure the system
CONFIGDIR="/etc/postgresql/9.4/main"
CONFIGF=$CONFIGDIR/pg_hba.conf

echo "# Require MD5 for local IPv4/6 connections" >> $CONFIGF
echo "host  all all 0.0.0.0/0    md5"          >> $CONFIGF

# Start the server
sudo /etc/init.d/postgresql start

# Create the 'gis' user
sudo -u postgres psql -c "CREATE USER gis WITH PASSWORD 'gis'"

# Create the 'gis' database
sudo -u postgres psql -c "CREATE DATABASE gis"

# Grant privileges
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE gis TO gis;"

# Configure postgis
sudo -u postgres psql -d gis -c "CREATE EXTENSION postgis"

# Disable WAL logging
CONFIGF=$CONFIGDIR/postgresql.conf
echo "fsync = off" >> $CONFIGF
echo "synchronous_commit = off" >> $CONFIGF
echo "listen_addresses = '*'" >> $CONFIGF
echo "checkpoint_segments = 40" >> $CONFIGF

# Check that the database server accepts the configuration
sudo /etc/init.d/postgresql restart

# Shutdown
sudo /etc/init.d/postgresql stop


#!/bin/bash

# Title: Install Riak and dependencies
# Author: Allan Paul "Pogz" Sy Ortile
# Date: 2016-07-04
# Version: 0.03 (2016-09-26)
# Notes:
#	0.01 - Recycled the old code from the DevRel setup and removed some useless stuff.
# Todo:
# - Fix setting limits.

clear

# Read the config file
echo "==== Reading the config.cfg file ===="
source /home/vagrant/provision/config.cfg

echo "==== Starting installation of Basho Erlang dependencies ===="

echo "== Updating apt =="
sudo apt-get update

echo "== Installing Basho Erlang dependencies =="
sudo apt-get install -y libpam0g-dev libssl0.9.8

echo "== Escalate privileges =="
sudo su

echo "== Go back to the home directory =="
cd ~

echo "== Installing Riak dependencies =="
# Double check the dependencies, some might not be needed
sudo apt-get -y install build-essential libc6-dev-i386 git libpam0g-dev

echo "== Go back to the home directory =="
cd ~

# Check the config if we're installing Riak or Riak TS
if [ $INSTALL_WHAT = "ts" ]
  then
  # Put TS installation stuff here
  echo "== Fetching Riak TS =="
  wget $RIAKTS_PACKAGE

  echo "== Installing Riak TS Package =="
  # This will get the filename from the $RIAK_PACKAGE variable in the config
  sudo dpkg -i ${RIAKTS_PACKAGE##*/}

else
  echo "== Fetching Riak =="
  wget $RIAK_PACKAGE

  echo "== Installing Riak Package =="
  # This will get the filename from the $RIAK_PACKAGE variable in the config
  sudo dpkg -i ${RIAK_PACKAGE##*/}
fi

echo "== Setting Limits =="
echo "root soft nofile 4096" >> /etc/security/limits.conf
echo "root hard nofile 32768" >> /etc/security/limits.conf
echo "riak soft nofile 4096" >> /etc/security/limits.conf
echo "riak hard nofile 32768" >> /etc/security/limits.conf
ulimit -n 32768

echo "==== DONE ===="

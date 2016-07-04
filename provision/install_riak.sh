#!/bin/bash

# Title: Install Riak and dependencies
# Author: Allan Paul "Pogz" Sy Ortile
# Date: 2016-07-04
# Version: 0.01 (2016-07-04)
# Notes:
#	0.01 - Recycled the old code from the DevRel setup and removed some useless stuff.

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

echo "== Fetching Riak =="
wget $RIAK_PACKAGE

echo "== Installing Riak Package =="
# This will get the filename from the $RIAK_PACKAGE variable in the config
sudo dpkg -i ${RIAK_PACKAGE##*/}


echo "== Setting Limits =="
echo "root soft nofile 4096" >> /etc/security/limits.conf
echo "root hard nofile 32768" >> /etc/security/limits.conf
echo "riak soft nofile 4096" >> /etc/security/limits.conf
echo "riak hard nofile 32768" >> /etc/security/limits.conf

echo "== Starting Riak node =="
riak start

echo "== Pinging Riak node =="
riak ping

echo "==== DONE ===="

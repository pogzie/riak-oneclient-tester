#!/bin/bash

# Title: Start Riak and initialize environment variables
# Author: Allan Paul "Pogz" Sy Ortile
# Date: 2016-07-04
# Version: 0.03 (2016-09-26)
# Notes:
# Todo:

clear

# Read the config file
echo "==== Reading the config.cfg file ===="
source /home/vagrant/provision/config.cfg

echo "==== Starting Riak node ===="
sudo su

echo "== Changing directory to ~ =="
cd ~

# I forgot to add this for some reason.
echo "== Starting riak =="
ulimit -n 65536
riak start

echo "== Pinging Riak node =="
riak ping

echo "== Set environment variables =="
# For NodeJS client
export NODE_PATH=/usr/lib/node_modules

# For Go client
export GOPATH=$HOME
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin

echo "==== Done ===="

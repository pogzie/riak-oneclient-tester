#!/bin/bash

# Title: Start Riak and initialize environment variables
# Author: Allan Paul "Pogz" Sy Ortile
# Date: 2016-07-04
# Version: 0.01 (2016-07-04)
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

echo "== Pinging Riak node =="
riak ping

echo "== Set environment variables =="
# For NodeJS client
export NODE_PATH=/usr/local/lib/node_modules

# For Go client
export GOPATH=$HOME
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin

echo "==== Done ===="

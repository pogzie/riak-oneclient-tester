#!/bin/bash

# Title: Install Riak clients and dependencies
# Author: Allan Paul "Pogz" Sy Ortile
# Date: 2016-07-04
# Version: 0.01 (2016-07-04)
# Notes:
# Todo:
#	- DotNet still broken. Fix this.

clear

# Read the config file
echo "==== Reading the config.cfg file ===="
source /home/vagrant/provision/config.cfg

echo "==== Starting installation of client and its dependencies ===="

echo "== Installing additional dependencies =="
sudo apt-get update
sudo apt-get -y install git

echo "== Installing DotNet Client =="
echo "Installing dependencies."
echo "Work in progress. Skipping."

echo "== Installing Erlang Client =="
echo "Installing dependencies."
sudo apt-get -y install erlang-parsetools erlang-dev erlang-syntax-tools
cd ~
git clone https://github.com/basho/riak-erlang-client/
cd riak-erlang-client
make
erl -pa ebin deps/*/ebin

echo "== Installing Go Client =="
echo "Installing dependencies."
cd ~
wget https://storage.googleapis.com/golang/go1.5.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.5.linux-amd64.tar.gz
export GOPATH=$HOME
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin
go version
mkdir riak-go-client
cd riak-go-client
# Apparently this craps on to your home directory. Fix this in the future
go get github.com/basho/riak-go-client

echo "== Installing Java Client =="
# Pull the jar files from here: http://riak-java-client.s3.amazonaws.com/index.html
echo "Installing dependencies."
sudo apt-get -y install openjdk-7-jdk
echo "Downloading JAR file."
cd ~
mkdir riak-java-client
cd riak-java-client
wget http://riak-java-client.s3.amazonaws.com/riak-client-2.0.5-jar-with-dependencies.jar

echo "== Installing NodeJS Client =="
echo "Installing dependencies."
sudo apt-get -y install npm node nodejs
cd ~
sudo npm install --global --save basho-riak-client
#sudo npm link winston
export NODE_PATH=/usr/local/lib/node_modules
mkdir riak-nodejs-client

# I think either you install riak-php-client via composer or the source
# Since the sample script includes the full path, I guess installation via composer could be removed
echo "== Installing PHP Client =="
echo "Installing dependencies."
sudo apt-get -y install curl php5-cli php5-curl
cd ~
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
git clone https://github.com/basho/riak-php-client
cd riak-php-client
composer update
composer require "basho/riak": "3.0.*"

echo "== Installing Python Client =="
echo "Installing dependencies."
sudo apt-get -y install python-pip python-dev libffi-dev libssl-dev
cd ~
git clone https://github.com/basho/riak-python-client
cd riak-python-client
sudo pip install riak
sudo pip install cryptography
sudo python setup.py install

echo "== Installing Ruby Client =="
echo "Installing dependencies."
sudo apt-get -y install
cd ~
sudo gem install riak-client
mkdir riak-ruby-client

echo "==== Done ===="

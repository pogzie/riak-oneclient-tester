#!/bin/bash

# Title: Install Riak client tester scripts
# Author: Allan Paul "Pogz" Sy Ortile
# Date: 2016-07-04
# Version: 0.01 (2016-07-04)
# Notes:
# Todo:
# 	- DotNet tester

clear

# Read the config file
echo "==== Reading the config.cfg file ===="
source /home/vagrant/provision/config.cfg

echo "==== Starting installation of client tester scripts ===="

echo "== Changing directory to ~ =="
cd ~

echo "== Pulling the repository =="
git clone $RIAK_CLIENT_TESTER


echo "== Running client tests =="
sudo su

# Riak DotNet
echo "== Running Riak DotNet Tests =="
echo "Work in progress."

# Riak Erlang
echo "== Running Riak Erlang Tests =="
cd ~
cd ${RIAK_CLIENT_TESTER##*/}
cd erlang
erlc riak.erl
erl -pa ~/riak-erlang-client/ebin ~/riak-erlang-client/deps/*/ebin -noshell -s riak start -s init stop

# Riak Go
echo "== Running Riak Go Tests =="
export GOPATH=$HOME
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin
cd ~
cd ${RIAK_CLIENT_TESTER##*/}
cd go
go build
./go

# Riak Java
echo "== Running Riak Java Tests =="
cd ~
cd ${RIAK_CLIENT_TESTER##*/}
cd java
javac -cp ~/riak-java-client/riak-client-2.0.5-jar-with-dependencies.jar Riak.java
# Doesnt like ~ here
java -cp .:/root/riak-java-client/riak-client-2.0.5-jar-with-dependencies.jar Riak

# Riak NodeJS
echo "== Running Riak NodeJS Tests =="
cd ~
cd ${RIAK_CLIENT_TESTER##*/}
cd nodejs
export NODE_PATH=/usr/local/lib/node_modules
nodejs riak.js

# Riak PHP
echo "== Running Riak PHP Tests =="
cd ~
cd ${RIAK_CLIENT_TESTER##*/}
cd php
php riak.php

# Riak Python
echo "== Running Riak Python Tests =="
cd ~
cd ${RIAK_CLIENT_TESTER##*/}
cd python
python riak.py

# Riak Ruby
echo "== Running Riak Ruby Tests =="
cd ~
cd ${RIAK_CLIENT_TESTER##*/}
cd ruby
ruby riak.rb

echo "==== Done ===="

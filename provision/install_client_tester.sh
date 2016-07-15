#!/bin/bash

# Title: Install Riak client tester scripts
# Author: Allan Paul "Pogz" Sy Ortile
# Date: 2016-07-04
# Version: 0.02 (2016-07-14)
# Notes:
# 0.02 - Fixed Go to use go run (rather than building and running separately)
#       - Fixed Java to be less dependent on hardcoded file names
# Todo:
# - DotNet tester

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

if [ $INSTALL_CLIENTS = "true" ]
then

      # Riak DotNet
      echo "== Running Riak DotNet Tests =="
      if [ $INSTALL_DOTNET = "true" ]
      then
        echo "Work in progress."
      else
        echo "INSTALL_DOTNET is set to $INSTALL_DOTNET. No test will run."
      fi


      # Riak Erlang
      echo "== Running Riak Erlang Tests =="
      if [ $INSTALL_ERLANG = "true" ]
      then
        cd ~
        cd ${RIAK_CLIENT_TESTER##*/}
        cd erlang
        erlc riak.erl
        erl -pa ~/riak-erlang-client/ebin ~/riak-erlang-client/deps/*/ebin -noshell -s riak start -s init stop
      else
        echo "INSTALL_ERLANG is set to $INSTALL_ERLANG. No test will run."
      fi

      # Riak Go
      echo "== Running Riak Go Tests =="
      if [ $INSTALL_GO = "true" ]
      then
        export GOPATH=$HOME
        export GOROOT=/usr/local/go
        export PATH=$PATH:$GOROOT/bin
        cd ~
        cd ${RIAK_CLIENT_TESTER##*/}
        cd go
        go run riak.go
      else
        echo "INSTALL_GO is set to $INSTALL_GO. No test will run."
      fi



      # Riak Java
      echo "== Running Riak Java Tests =="
      if [ $INSTALL_JAVA = "true" ]
      then
        cd ~
        cd ${RIAK_CLIENT_TESTER##*/}
        cd java
        javac -cp ~/riak-java-client/${JAVA_CLIENT_JAR##*/} Riak.java
        # Doesnt like ~ here
        java -cp .:/root/riak-java-client/${JAVA_CLIENT_JAR##*/} Riak
      else
        echo "INSTALL_JAVA is set to $INSTALL_JAVA. No test will run."
      fi


      # Riak NodeJS
      echo "== Running Riak NodeJS Tests =="
      if [ $INSTALL_NODEJS = "true" ]
      then
        cd ~
        cd ${RIAK_CLIENT_TESTER##*/}
        cd nodejs
        export NODE_PATH=/usr/local/lib/node_modules
        nodejs riak.js
      else
        echo "INSTALL_NODEJS is set to $INSTALL_NODEJS. No test will run."
      fi


      # Riak PHP
      echo "== Running Riak PHP Tests =="
      if [ $INSTALL_PHP = "true" ]
      then
        cd ~
        cd ${RIAK_CLIENT_TESTER##*/}
        cd php
        php riak.php
      else
        echo "INSTALL_PHP is set to $INSTALL_PHP. No test will run."
      fi


      # Riak Python
      echo "== Running Riak Python Tests =="
      if [ $INSTALL_PYTHON = "true" ]
      then
        cd ~
        cd ${RIAK_CLIENT_TESTER##*/}
        cd python
        python riak.py
      else
        echo "INSTALL_PYTHON is set to $INSTALL_PYTHON. No test will run."
      fi


      # Riak Ruby
      echo "== Running Riak Ruby Tests =="
      if [ $INSTALL_RUBY = "true" ]
      then
        cd ~
        cd ${RIAK_CLIENT_TESTER##*/}
        cd ruby
        ruby riak.rb
      else
        echo "INSTALL_RUBY is set to $INSTALL_RUBY. No test will run."
      fi

else
  echo "INSTALL_CLIENTS is set to $INSTALL_CLIENTS. No test will run."
fi

echo "==== Done ===="

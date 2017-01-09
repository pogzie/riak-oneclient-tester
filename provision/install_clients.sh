#!/bin/bash

# Title: Install Riak clients and dependencies
# Author: Allan Paul "Pogz" Sy Ortile
# Date: 2016-07-04
# Version: 0.02 (2016-07-14)
# Notes:
#   0.02 - Added encompassing IFs and smaller Ifs for managing what clients to install
# Todo:
#	- DotNet still broken. Fix this.
# - Need to add install checks so that efforts would not double when starting.

clear

# Read the config file
echo "==== Reading the config.cfg file ===="
source /home/vagrant/provision/config.cfg

echo "==== Starting installation of client and its dependencies ===="

echo "== Installing additional dependencies =="
sudo apt-get update
sudo apt-get -y install git

if [ $INSTALL_CLIENTS = "true" ]
then

    ##
    echo "== Installing DotNet Client =="
    if [ $INSTALL_DOTNET = "true" ]
    then
      echo "Installing dependencies."
      echo "Work in progress. Skipping."
    else
      echo "INSTALL_DOTNET is set to $INSTALL_DOTNET"
    fi

    ##
    echo "== Installing Erlang Client =="
    if [ $INSTALL_ERLANG = "true" ]
    then
      echo "Installing dependencies."
      sudo apt-get -y install erlang-parsetools erlang-dev erlang-syntax-tools
      cd ~
      git clone $ERLANG_CLIENT_REPO
      cd riak-erlang-client
      make
      erl -pa ebin deps/*/ebin
    else
      echo "INSTALL_ERLANG is set to $INSTALL_ERLANG"
    fi

    ##
    echo "== Installing Go Client =="
    if [ $INSTALL_GO = "true" ]
    then
      echo "Installing dependencies."
      cd ~
      wget $GO_CLIENT_INSTALLER
      # This gets the filename after the slash
      sudo tar -C /usr/local -zxvf ${GO_CLIENT_INSTALLER##*/}
      export GOPATH=$HOME
      export GOROOT=/usr/local/go
      export PATH=$PATH:$GOROOT/bin
      go version
      mkdir riak-go-client
      cd riak-go-client
      # Apparently this craps on to your home directory. Fix this in the future
      go get $GO_CLIENT_REPO
    else
      echo "INSTALL_GO is set to $INSTALL_GO"
    fi

    ##
    echo "== Installing Java Client =="
    if [ $INSTALL_JAVA = "true" ]
    then
      # Pull the jar files from here: http://riak-java-client.s3.amazonaws.com/index.html
      echo "Installing dependencies."
      # Commented out in favor of Java 8
      # sudo apt-get -y install openjdk-7-jdk
      sudo apt-add-repository ppa:webupd8team/java
      sudo apt-get update
      # Accept the license
      echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
      echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
      sudo apt-get -y install oracle-java8-installer
      echo "Downloading JAR file."
      cd ~
      mkdir riak-java-client
      cd riak-java-client
      wget $JAVA_CLIENT_JAR
    else
      echo "INSTALL_JAVA is set to $INSTALL_JAVA"
    fi

    ##
    echo "== Installing NodeJS Client =="
    if [ $INSTALL_NODEJS = "true" ]
    then
      echo "Installing dependencies."
      #sudo apt-get -y install npm node nodejs
      sudo apt-get -y install python-software-properties
      curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
      sudo apt-get -y install nodejs
      cd ~
      sudo npm install --global --save basho-riak-client
      #sudo npm link winston
      export NODE_PATH=/usr/local/lib/node_modules
      mkdir riak-nodejs-client
    else
      echo "INSTALL_NODEJS is set to $INSTALL_NODEJS"
    fi

    ##
    echo "== Installing PHP Client =="
    if [ $INSTALL_PHP = "true" ]
    then
      echo "Installing dependencies."
      sudo apt-get -y install curl php5-cli php5-curl
      cd ~
      curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
      git clone $PHP_CLIENT_REPO
      cd riak-php-client
      composer update
      composer require $PHP_COMPOSER_INSTALL
    else
      echo "INSTALL_PHP is set to $INSTALL_PHP"
    fi

    ##
    echo "== Installing Python Client =="
    if [ $INSTALL_PYTHON = "true" ]
    then
      echo "Installing dependencies."
      sudo apt-get -y install python-pip python-dev libffi-dev libssl-dev
      cd ~
      git clone $PYTHON_CLIENT_REPO
      cd riak-python-client
      sudo pip install cryptography
      sudo pip install riak
      sudo python setup.py install
    else
      echo "INSTALL_PYTHON is set to $INSTALL_PYTHON"
    fi


    ##
    echo "== Installing Ruby Client =="
    if [ $INSTALL_RUBY = "true" ]
    then
      echo "Installing dependencies."
      sudo apt-get -y install ruby
      cd ~
      sudo gem install riak-client
      mkdir riak-ruby-client
    else
      echo "INSTALL_RUBY is set to $INSTALL_RUBY"
    fi

else
  echo "INSTALL_CLIENTS is set to $INSTALL_CLIENTS"
fi

echo "==== Done ===="

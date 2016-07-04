# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

	config.vm.provider "virtualbox" do |v|
	  v.memory = 1024
	  v.cpus = 2
	end

  config.vm.provision "shell",
    inline: "date"

  # This drops this to the vagrant home directory under provision folder
  config.vm.provision "file",
    source: "provision",
    destination: "~/provision",
    run: "always"

  # Install Basho Erlang with Riak and all its dependencies.
  # Note that Erlang is installed in the vagrant home directory and Riak in root
  config.vm.provision "shell",
    inline: "/bin/bash /home/vagrant/provision/install_riak.sh"

  # Install Riak clients and dependencies
  config.vm.provision "shell",
    inline: "/bin/bash /home/vagrant/provision/install_clients.sh"

  # Run Riak
  # This initializes environment variables for the clients
  config.vm.provision "shell",
    inline: "/bin/bash /home/vagrant/provision/start_riak.sh",
    run: "always"

  # Install Riak client testers
  # This will be installed in root
  config.vm.provision "shell",
    inline: "/bin/bash /home/vagrant/provision/install_client_tester.sh",
    run: "always"

  # TODO: Split client tests from install
  # This is so that it could run every boot.

  config.vm.provision "shell",
    inline: "date"

end

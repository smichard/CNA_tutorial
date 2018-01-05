# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "williamyeh/ubuntu-trusty64-docker"
  
   # Set up hostname
  config.vm.hostname = "dockerhost"
  config.ssh.forward_x11 = true

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 3000 , host: 3000
  # config.vm.network "forwarded_port", guest: 5000 , host: 5000
  # config.vm.network "forwarded_port", guest: 8000, host: 8000
  # config.vm.network "forwarded_port", guest: 8080, host: 8080
  # config.vm.network "forwarded_port", guest: 9000 , host: 9000
  # config.vm.network "forwarded_port", guest: 9001 , host: 9001
  # config.vm.network "forwarded_port", guest: 9002 , host: 9002
  # config.vm.network "forwarded_port", guest: 9003 , host: 9003
  # config.vm.network "forwarded_port", guest: 9004 , host: 9004
  # config.vm.network "forwarded_port", guest: 30080 , host: 30080
  # config.vm.network "forwarded_port", guest: 30022 , host: 30022
  
  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.58.2"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
	  vb.name = "dockerbox"
    vb.memory = "4096"
    vb.cpus = 1
    vb.customize ['modifyvm', :id, '--nictype1', 'Am79C973']
    vb.customize ['modifyvm', :id, '--nicpromisc1', 'allow-all']
    vb.customize ['modifyvm', :id, '--nictype2', 'Am79C973']
    vb.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # install necessary packages
  config.vm.provision "install", type: "shell", path: "setupVagrant.sh"
end

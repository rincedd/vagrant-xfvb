# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'
CONF = YAML.load(File.open(File.join(File.dirname(__FILE__), "config.yml"), File::RDONLY).read)

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "puppetlabs/ubuntu-14.04-64-puppet"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # forward VNC viewer ports
  config.vm.network :forwarded_port, :guest => 5900, :host => 5900

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
     # Use VBoxManage to customize the VM. For example to change memory:
     vb.customize ["modifyvm", :id, "--memory", "2048"]
  end

  # update package index
  config.vm.provision "shell", :inline => "apt-get update -y"

  # install puppet modules
  config.vm.provision "shell", :path => "install-puppet-modules.sh"

  # provision using puppet
  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "puppet"
    puppet.module_path = "puppet/modules"
    puppet.manifest_file = "site.pp"
    puppet.facter = {
        :jenkins_master_url => CONF['jenkins']['master_url'],
        :jenkins_slave_jnlp_url => CONF['jenkins']['slave_jnlp'],
        :jenkins_slave_secret => CONF['jenkins']['slave_secret'],
        :jenkins_slave_home => CONF['jenkins']['slave_home']
    }
  end
end

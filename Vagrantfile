# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "Ubunut 12.0.4 Puppet"
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210.box"

  config.ssh.forward_agent = true

  config.vm.provision "shell",
      privileged: true,
      inline: "puppet apply /vagrant/manifests/site.pp --modulepath=/vagrant/modules"
end

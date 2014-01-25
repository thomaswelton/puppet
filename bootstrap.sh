#!/bin/bash

wget https://apt.puppetlabs.com/puppetlabs-release-precise.deb
sudo dpkg -i puppetlabs-release-precise.deb
sudo apt-get update
apt-get -y install puppet-common
rm puppetlabs-release-precise.deb

git pull
git submodule init
git submodule update --recursive

puppet apply "$HOME/.puppet/manifests/site.pp" --modulepath="$HOME/.puppet/modules"

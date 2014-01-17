#!/bin/bash

wget https://apt.puppetlabs.com/puppetlabs-release-precise.deb
sudo dpkg -i puppetlabs-release-precise.deb
sudo apt-get update
apt-get -y install puppet-common
rm puppetlabs-release-precise.deb

git submodule init
git submodule update --recursive

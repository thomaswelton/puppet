# Puppet Configuaration

Installs commonly required tools and programs. Designed to work on Ubuntu 12.04

Firstly install puppet

```
wget https://apt.puppetlabs.com/puppetlabs-release-precise.deb
sudo dpkg -i puppetlabs-release-precise.deb
sudo apt-get update
apt-get -y install puppet-common
rm puppetlabs-release-precise.deb
```

Then install the required puppet modules

puppet module install puppetlabs/vcsrepo
puppet module install garethr/docker
puppet module install jfryman/nginx
puppet module install willdurand/nodejs
puppet module install maestrodev/ssh_keygen
puppet module install davidcollom/raxmonitoragent

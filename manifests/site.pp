## Setup a stage to be run before all other Puppet code
## This will update the system and install puppet modules
stage { "init": before  => Stage["main"] }

class { "setup":
  stage => init,
}

class setup{
    exec{ 'apt-get update':
        command => "/usr/bin/apt-get update"
    }
}

node default{
    # Make SSH keys for root user
    user { 'root': }
    ssh_keygen { 'root':
        home => '/root',
        require => User['root']
    }

    $packages = [ "vim", "zsh", "rubygems", "git"]
    package { $packages:
        ensure => "installed",
        provider => apt
    }

    $gems = [ "hub", "hiera", "hiera-puppet" ]
    package { $gems:
        ensure => "installed",
        provider => gem,
        require => Package['rubygems']
    }

    exec { 'install hub':
        cwd => '/',
        path => [ '/usr/local/bin', '/usr/bin', '/bin' ],
        command => 'hub hub standalone > /usr/bin/hub && chmod +x /usr/bin/hub',
        creates => '/usr/bin/hub',
        require => Package['hub']
    }

    ## Create user thomaswelton
    user { 'thomaswelton':
        comment => 'Thomas Welton',
        home    => '/home/thomaswelton',
        shell   => '/bin/zsh',
        managehome => 'true',
        password  => '$6$YiYH0Utf$qM7MSnx29gvLZE3l8xMYdgr4P6wirdCkgSmF7zLkzltgXnVrXK6xtjFAb6faGCNO9a4xywwTSPuyvKwzCc5P5.'
    }

    ssh_keygen { 'thomaswelton':
        require => User['thomaswelton']
    }

    ## Clone dotfiles for thomaswelton
    vcsrepo { '/home/thomaswelton/.dotfiles':
        ensure   => present,
        provider => git,
        source   => 'git://github.com/thomaswelton/dotfiles.git',
    }


    ## Install docker
    class { 'docker':
      tcp_bind    => 'tcp://127.0.0.1:4243',
      socket_bind => 'unix:///var/run/docker.sock',
    }

    ## Pull our common dokcer images
    $docker_images = ['thomaswelton/ubuntu', 'thomaswelton/ubuntu-php']
    docker::image { $docker_images:
        require => Package['docker']
    }


    ## Install nginx
    ## class { 'nginx': }

    class { 'nodejs':
        version => 'v0.10.17',
        make_install => false
    }

    $npm_packages = ['bower', 'grunt-cli']
    package { 'bower':
        provider => npm
    }


    class supervisord {
        $install_pip  => true,
    }

    ## Install shipyard
    import 'shipyard.pp'
}

node shipyard {

	firewall { '4500 allow shipyard-agent':
		port   => [4500],
		proto  => tcp,
		action => accept,
	}

	wget::fetch { "shipyard-agent":
		source      => 'https://github.com/shipyard/shipyard-agent/releases/download/v0.0.9/shipyard-agent',
		destination => '/usr/local/bin/shipyard-agent',
		timeout     => 0,
		verbose     => false,
	}

	file{ '/usr/local/bin/shipyard-agent':
		mode => '+x',
		require => Wget['shipyard-agent']
	}

	docker::run { 'shipyard':
		image   => 'shipyard/shipyard',
		require => Package['docker'],
		ports => ['80:80', '8000:8000'],
	}

}
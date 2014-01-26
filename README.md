# Puppet Configuaration

Installs commonly required tools and programs. Designed to work on Ubuntu 12.04

Clone into /root/.puppet
Run `/root/.puppet/bootstrap.sh`

Run shipyard

`docker run -i -t -d -p 80:80 -p 8000:8000 shipyard/shipyard`

Visit http://example.com:8000 and login

* Username: `admin`
* Password: `shipyard`

Register the server using shipyard-agent

`shipyard-agent -url http://example.com:8000 -register`

It will output an "agent key".  You will then need to authorize the host in
Shipyard.  Login to your Shipyard instance and select "Hosts".  Click on the
action menu for the host and select "Authorize Host".

Once authorized, you can start the agent:

`./shipyard-agent -url http://myshipyardhost -key myshipyardkey`

The agent will need to be run in the background. So create a supervisor program `/etc/supervisor/conf.d/shipyard-agent.conf`

```
[program:shipyard-agent]
command=shipyard-agent -url http://myshipyardhost -key myshipyardkey
autostart=true
autorestart=true
stderr_logfile=/var/log/shipyard-agent.log
stdout_logfile=/var/log/shipyard-agent.log
```

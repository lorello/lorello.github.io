# SystemD

Services has a new name... happy! They are now *units*

Look also:

 - [Offiial docs](https://www.freedesktop.org/wiki/Software/systemd/)
 - [SystemD for Upstart Users](https://wiki.ubuntu.com/SystemdForUpstartUsers)
 - [RedHat docs](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/System_Administrators_Guide/chap-Managing_Services_with_systemd.html)

## paths

Central path system-wide
    /lib/systemd/system		(debian-based)
    /usr/lib/systemd/system/    (redhat-based)

Put general custom units in

    /etc/systemd/system/


## system logs

Show current logs

    journalctl -n         # show onetime
    journalctl -f         # tail logs
    

Show today logs from two units:

    journalctl -u nginx.service -u php-fpm.service --since today

Show kernel logs

    journalctl -k                # last boot
    journalctl -k -b -5          # five boots ago

Show by field (`man systemd.journal-fields`)

    journalctl _UID=33 --since today

Show only error messages, from boot

    journalctl -p err -b

Other interesting options

    --no-pager        # don't use more
    --no-full         # truncate at last column
    -a                # show all, even non printable chars


## Override a systemd profile

To override some attributes inside example.service, create

    /etc/systemd/system/example.service.d/mycustom.conf

and write there you customizations

## Simple service definition

    [Unit]
    Description=ROT13 demo service
    After=network.target
    After=mysqld.service
    StartLimitIntervalSec=0
    
    [Service]
    Type=simple
    Restart=on-failure
    RestartSec=2		# restart after 2 seconds (default 100ms)
    User=centos
    ExecStart=/usr/bin/env php /path/to/server.php

    [Install]
    WantedBy=multi-user.target

See also [Unit Manual](https://www.freedesktop.org/software/systemd/man/systemd.unit.html)

## Service Auto-Restart

Example 1: try a restart per second and stop after 5 attempts in 10 seconds

    [Unit]
    StartLimitBurst=5		# default
    StartLimitIntervalSec=10	# default
    [Service]
    Restart=always
    RestartSec=1		# default: 100ms

Example 2: try a restart every 30 seconds and stop after 5 attempts in 5 minutes
	   reboot after 5 failed attempts to restart the service
    [Unit]
    StartLimitBurst=5		# default
    StartLimitIntervalSec=5min	# default
    StartLimitAction=reboot 

    [Service]
    Restart=always
    RestartSec=30		# default: 100ms
    
_Note that `systemctl reset-failed` will cause the restart rate counter for a 
service to be flushed, which is useful if the administrator wants to manually
start a unit and the start limit interferes with that._

## Manage process limits

Check current ulimits for an hypotethical MongoDB

    root@xenial:~# systemctl --no-pager show mongodb.service | egrep 'NOFILE|NPROC'

Change values

    root@xenial:~# cat /etc/systemd/system/mongodb.service
    [Service]
    LimitNOFILE=64000
    LimitNPROC=infinity

    root@xenial:~# systemctl daemon-reload 



# Services

What services are started on boot?

    service --status-all

- [ + ] – Services with this sign are currently running.
- [ – ] – Services with this sign are not currently running..
- [ ? ] – Services that do not have a status switch.

Remove a service

    update-rc.d -f apache2 remove

Add a service

    update-rc.d apache2 defaults

## Systemd

Files path

    /usr/lib/systemd
      /user
      /system

    ~/.config/systemd
      /user

Useful commands

    systemctl (enable|try-reload-or-restart|list-units|kill|status|show|cat) <NAME>

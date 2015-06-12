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



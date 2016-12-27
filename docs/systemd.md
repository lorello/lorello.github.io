# SystemD

Services has a new name... happy! They are now *units*

## paths

    /lib/systemd/system

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





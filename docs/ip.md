# Linux IP

## Devices

Show and change device settings
    ip link set dev eth2 up|down
    ip link set dev eth0 up|down arp on|off name NAME mtu 9000

Show current settings for interface
    ip link show dev NAME

Show only UP interfaces
    ip link show up

## Routing

    ip route show
    ip route add 192.168.1.0/24 dev eth0
    ip route add default via 192.168.1.254

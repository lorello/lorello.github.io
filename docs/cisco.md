# Basic Cisco CLI

## Shutdown an interface

    # enable
    # configure terminal
    (config)# interface FastEthernet 0/1
    (config-subif)# shutdown
    (config-subif)# end
    # write

## Set a description

    # en
    # conf t
    (config)# int FastEthernet 0/1
    (config-subif)# description This is 1st Port of My Switch
    (config-subif)# end
    # write

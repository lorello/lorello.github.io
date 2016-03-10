# Basic Cisco CLI

## List intefaces with descriptions

    show int description

## Show detailed config for a specific interface

    show running-config interface FastEthernet4/38

## Show list of vlan and connected interfaces

    show vlan brief

## Setup an interface with

    interface GigabitEthernet1/0/3
     description Gianni's desktop
     switchport access vlan 100
     switchport trunk native vlan 100
     switchport trunk allowed vlan 100,104
     switchport mode trunk
     spanning-tree bpduguard disable
    end

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

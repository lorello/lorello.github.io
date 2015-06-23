# Sshuttle


Transparent proxy server that works as a poor man's VPN. Forwards over ssh. Doesn't require admin. Works with Linux and MacOS. Supports DNS tunneling.

## Setup

    git clone https://github.com/apenwarr/sshuttle
 
## Use

    ./sshuttle -r you@somewhere.tld 0/0
    ./sshuttle -r you@somewhere.tld 192.168.33.0/24

Add `--dns` to use remote dns

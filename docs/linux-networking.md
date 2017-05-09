# Performance tuning

Beyond the 10k connections and similar topics

## Prevent source port exhausting

Check connections totals per state:

    netstat -nat | awk '{print $6}' | sort | uniq -c | sort -n

Increase capacity of port use and reuse:

    sysctl -w net.ipv4.ip_local_port_range="15000 61000"	(default: 32768 61000)
    sysctl -w net.ipv4.tcp_fin_timeout=30			(default: 60)

Backlog of connections

    sysctl -w net.core.netdev_max_backlog = 2000 	(default: 1000)
    sysctl -w net.ipv4.tcp_max_syn_backlog = 2048	(default: 1024)
    net.core.somaxconn = 1024				(default: 128)

Accelerate the socket recycle capacity of kernel:

    sysctl -w net.ipv4.tcp_tw_recycle=1			(default: 0)
    sysctl -w net.ipv4.tcp_tw_reuse=1			(default: 0)





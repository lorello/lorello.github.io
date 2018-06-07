# Fabio Load Balancer

## SSL 

Configuration using environment variables
```
version: "2.3"
services:
  lb:
    image: fabiolb/fabio:1.5.8-go1.10
    container_name: fabio
    restart: unless-stopped
    cpus: 2
    mem_limit: '256m'
    mem_reservation: '128m'
    network_mode: 'host'
#    ports:
#      - 80:80
#      - 443:443
#      - 9998:9998
    environment:
      FABIO_proxy_cs: 'cs=mydomain;type=consul;cert=http://127.0.0.1:8500/v1/kv/ssl'
      FABIO_proxy_addr: ':80,:443;cs=mydomain'
      FABIO_PROXY_SHUTDOWNWAIT: '10s'
      FABIO_proxy_gzip_contenttype: '^(text/.*|application/(javascript|json|font-woff|xml)|.*\+(json|xml))(;.*)?$$'
      FABIO_log_access_target: 'stdout'
      FABIO_log_access_format: 'combined'
      FABIO_log_level: 'WARN'
      FABIO_registry_consul_addr: '127.0.0.1:8500'
    
```

Storing the SSL certificates in consul KV store is simple:

    cat CA_intermediate.crt mydomain.crt | consul kv put ssl/mydomain-cert.pem -
    cat mydomain.key | mydomain consul kv put ssl/mydomain-key.pem -

Cert must contain the intermediate certificates, if they are available

Proxying Consul UI

route add consul consul.mydomain.tld http://127.0.0.1:8500

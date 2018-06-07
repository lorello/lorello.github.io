# Consul

https://consul.io

## Remove a dead service

    http put :8500/v1/agent/service/deregister/:ID

## Dev mode

    $ consul agent -server -dev -ui -client 0.0.0.0


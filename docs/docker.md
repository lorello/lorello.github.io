# Docker

## Basics

Search on Docker Hub Registry and pull an image to run locally

    docker search ubuntu
    docker pull ubuntu

Run a command in a box

    docker run <image> <command>

Example

    docker run ubuntu:14.04 /bin/echo 'Hello world'

And then?
    docker ps -l
    docker commit -m "bla bla" -u lorello <CONTAINER> <IMAGE:TAG>
    docker inspect <CONTAINER>

Containers are never ephimeral, but they get a name only with a `commit`

## Interactive and daemon containers

Run a container with a TTY and with an interactive STDIN

    docker run -t -i ubuntu:14.04 /bin/bash

Run a daemonized process inside a container, inspect logs realtime,
kill the container

    MYCONTAINER=$(docker run -d ubuntu:14.04 /bin/sh -c "while true; do echo hello world; sleep 1; done")
    docker logs $MYCONTAINER
    docker kill $MYCONTAINER

You can `save` the container created using

    docker commit -m "added stupid loop" -a lorello $MYCONTAINER lorello/stupid:trashme
    docker rmi lorello/stupid:trashme

Adding `-P` options to `run` command let docker maps any required network port to the host.
Then you can inspect ports mapped using the `ps` command or running

    docker ports $MYCONTAINER

## Dockerfile

Build & tag an image using a [Dockerfile](https://docs.docker.com/reference/builder)

    docker build -t="lorello/ubuntu:myapp" .

## Exposing services

Use `EXPOSE $port` inside Dockerfile and then run the container with

    $MYCONTAINER=$(docker run -d -P <IMAGE:TAG>)
    docker port $MYCONTAINER $PORT

## Clean unused images

Remove untagged images

    docker rmi -f $(docker images | grep "<none>" | awk "{print \$3}")

Remove unused images

    docker images -q |xargs docker rmi


# Volumes

## Data Volume Container

Create container volume for a mongodb server

    docker run -v /data/db –name db_data busybox echo Data only volume for mongo

Run mongo instance with mounted volume

    docker run -d -P –volumes-from db_data –name mymongo mongo

# Enter inside a running container (NSENTER)

Install `nsenter` utility and `docker-enter` command doing this on the host

    docker run --rm -v /usr/local/bin:/target jpetazzo/nsenter

Launch a bash inside the container $NAME running

    docker-enter $NAME bash

# Use MacVlan interfaces

Example: you want an `hipache` with a public interface directly connected
to phisycal device, skipping the default NAT of docker.

## Le the host use the macvlan interface

Move a host from traditional `eth0` interface to `macvlan` interface as main
network card, so it can play with a container that use `macvlan` interface

    ip addr del 10.1.1.123/24 dev eth0
    ip link add link eth0 dev eth0m type macvlan mode bridge
    ip link set eth0m up
    ip addr add 10.1.1.123/24 dev eth0m
    route add default gw 10.1.1.254

## Start a container that use the same macvlan interface

    CID=$(docker run -d ...)
    pipework eth0 $CID 10.1.1.234/24@10.1.1.254

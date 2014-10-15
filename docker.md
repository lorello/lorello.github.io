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
    

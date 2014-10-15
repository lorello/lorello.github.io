# Octohost

* [Official documentation](http://octohost.io/)
* [octo cli](https://www.octohost.io/octo-cli.html)

## How to deploy a container

[Create a container](https://docs.docker.com/articles/basics/) and add octohost as remote

    git remote add git@octo.lorello.it:<APPNAME>.git
    git push


## How to enable a new user on Octohost

    $ ssh root@octohost
    # gitreceive key-upload git

Paste the public key and press CTRL+D

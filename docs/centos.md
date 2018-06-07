# CentOS

## Repositories

### Find packages

Package that contains a binary:

```
rpm -qf which dig
```

List of files in a package

```
rpm -ql bind-utils
```

### Extra Packages (community approved by CentOS)

    # yum install epel-release

### Rackspace updated packages for PHP/Mysql/python

    # curl -fsSL https://setup.ius.io/ | sh

### Puppet collections

    # rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-(5|6|7).noarch.rpm

### Sysdig

sysdig requires kernel headers

    rpm --import https://s3.amazonaws.com/download.draios.com/DRAIOS-GPG-KEY.public
    curl -s -o /etc/yum.repos.d/draios.repo http://download.draios.com/stable/rpm/draios.repo

    yum -y install kernel-devel-$(uname -r)
    yum -y install sysdig

## Utils

```
rpm -Uvh https://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm
yum install -y htop byobu bind-utils
```


### Docker

#### Centos 6

Requires kernel >= 3.10, probably centos 6.5 and later

    curl -fsSL https://get.docker.com/ | sh
    sudo service docker start
    sudo chkconfig docker on
    sudo groupadd docker
    sudo usermod -aG docker `whoami`


#### Centos 7

Kernel upgrade

```
sudo rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
sudo rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm
sudo yum --disablerepo="*" --enablerepo="elrepo-kernel" list available
sudo yum --enablerepo=elrepo-kernel install -y kernel-lt
sudo grub2-set-default 0    # setta l'ultimo kernel instalato come default
```

Docker packages install

```
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine
sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce
sudo systemctl start docker
sudo docker run -it --rm hello-world
sudo systemctl enable docker
sudo groupadd docker
sudo usermod -aG docker $USER
```


### Netdata

Monitoring system

    yum install zlib-devel libuuid-devel libmnl-devel gcc make git autoconf autogen automake pkgconfig
    git clone https://github.com/firehol/netdata.git –depth=1 && cd netdata && ./netdata-installer.sh


For more info see also <https://wiki.centos.org/AdditionalResources/Repositories>

### Firewall

Check if fireall is enabled and how is configured

    firewall-cmd --state
    firewall-cmd --get-default-zone
    firewall-cmd --get-active-zones
    firewall-cmd --get-zones
    firewall-cmd --list-all
    firewall-cmd --get-services
    firewall-cmd --runtime-to-permanent

Open https from any

    firewall-cmd --zone=public --add-service=https --permanent
    firewall-cmd --reload

Open mysql from a specific IP

    firewall-cmd --zone=external --permanent --add-source="123.456.1.1/32"
    firewall-cmd --zone=external --permanent --add-service="mysql"
    firewall-cmd --reload

Open a custom port 

    firewall-cmd --zone=public --add-port=5000/tcp
    firewall-cmd --zone=public --add-port=4990-4999/udp

Open all traffic from a specific IP

    fireall-cmd --zone=trusted --permanent --add-source="123.456.1.1/32"


More info on the [official FirewallD homepage](http://www.firewalld.org/documentation/man-pages/firewall-cmd.html).


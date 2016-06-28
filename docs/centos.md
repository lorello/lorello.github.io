# CentOS

## Repositories

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

### Docker

Requires kernel >= 3.10, probably centos 6.5 and later

    curl -fsSL https://get.docker.com/ | sh
    sudo service docker start
    sudo chkconfig docker on
    sudo groupadd docker
    sudo usermod -aG docker `whoami`

### Netdata

Monitoring system

    yum install zlib-devel libuuid-devel libmnl-devel gcc make git autoconf autogen automake pkgconfig
    git clone https://github.com/firehol/netdata.git –depth=1 && cd netdata && ./netdata-installer.sh


For more info see also <https://wiki.centos.org/AdditionalResources/Repositories>

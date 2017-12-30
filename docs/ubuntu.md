# Ubuntu

## Change hostname

    sudo vim /etc/hosts
    sudo vim /etc/hostname
    sudo hostnamectl set-hostname <NEWNAME>
    systemctl restart systemd-logind.service

## Package install fixes

    apt-get clean
    apt-get autoremove
    apt-get update && sudo apt-get upgrade
    dpkg --configure -a
    apt-get install -f

In case of postinst/preinst issues, try also

    apt-get install -o APT::Immediate-Configure=false -f apt SOMEPACKAGE

## Things to check
    
    /var/log/auth.log
    /var/log/syslog
    /var/log/cloud-init.log
   
    service apparmor status
    apparmor_status
 

# Managing Logical Volumes

Imagine to manage SDB

## Create an LVM-ready partition /dev/sdb1 

Not strictly necessary, if not needed skip this step 
and use directly sdb device, instead of a partition

    fdisk /dev/sdb
    n p 1 t 8e p w

## Add LVM Magic

    pvcreate /dev/sdb1
    vgcreate hdd_vg /dev/sdb1
    lvcreate -L 150G -n vmware hdd_vg

    mkfs -t ext4 /dev/hdd_vg/vmstore

    blkid /dev/hdd_vg/vmstore
    
    mkdir -p /mnt/vmstore

edit /etc/fstab accordingly then

    mount -a



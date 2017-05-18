# Managing Logical Volumes

Imagine to manage SDB

## Show status of LVM devices / volumes / ...

    pvs
    vgs
    lvs

## Create an LVM-ready partition /dev/sdb1 

Not strictly necessary, if not needed skip this step 
and use directly sdb device, instead of a partition

    fdisk /dev/sdb
    n p 1 t 8e p w

## Add LVM Magic

    ( pvcreate /dev/sdb )
    vgcreate vg00 /dev/sdb

    lvcreate -L 150G -n mysql vg00	# defined size
    lvcreate -l95%VG -n mysql vg00 	# 95% of the size of the VG
    lvcreate -l90%FREE -n mysql vg00 	# 90% of the remaining free space in the Volume Group


    mkfs -t ext4 /dev/vg00/mysql

    blkid /dev/vg00/mysql
    
    mkdir -p /mnt/mysql

edit `/etc/fstab` accordingly then

    mount -a

    mkdir /mnt/mysql/{binlog,data}

## Extend existing volume

    lvextend -l +100G /dev/hdd_vg/vmstore
    resize2fs /dev/hdd_vg_vmstore



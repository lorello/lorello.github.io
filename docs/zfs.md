# ZFS

## Pool

    zpool create -f tank sda4

    zfs pool status

## Dataset and volumes

Managing volumes

    zfs create $pool/$volume
    zfs destroy $pool/$volume
    zfs status

### Volume options


    zfs create -o dedup=on -o compression=on -o mountpoint=/mnt/var tank/myvar

same as

    zfs create tank/myvar
    zfs set mountopoint=/mnt/var tank/myvar
    zfs set dedup=on tank/myvar
    zfs set compression=on tank/myvar

verify options

    zfs get all tank/myvar



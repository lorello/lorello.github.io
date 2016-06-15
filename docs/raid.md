# Linux Software Raid (MdAdm)

## Recover a standalone disk from RAID1 failure

    # Connect disk, suppose it get recognized as /dev/sdb

    # Array it's probably assembled automatically as `/dev/mdNNN`, but _inactive_
    root@motoko:~# cat /proc/mdstat
    Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5] [raid4] [raid10]
    md125 : inactive sdb6[0](S)
      953321472 blocks super 1.2

    md126 : inactive sdb1[0](S)
      19529728 blocks super 1.2

    md127 : inactive sdb5[1](S)
      3905528 blocks super 1.2

    root@motoko:~# mdadm --stop /dev/md125

    root@motoko:~# mdadm --assemble --force /dev/md0 /dev/sdb6`
    mdadm: /dev/md0 has been started with 1 drive (out of 2).

    root@motoko:~# cat /proc/mdstat
    Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5] [raid4] [raid10]
    md0 : active raid1 sdb6[0]
          953321336 blocks super 1.2 [2/1] [U_]

    unused devices: <none>

    root@motoko:~# mkdir /mnt/recovery
    root@motoko:~# mount /dev/md0 /mnt/recovery

    # if fails try also
    root@motoko:~# fsck -p /dev/md0

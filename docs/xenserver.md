# XenServer

## Backup script

https://github.com/markround/XenServer-snapshot-backup

### backup config

    xe vm-list

    export VM=a3308cee-c483-7d2c-708c-a9fd7d52ffe9

    # Backup using template saved on an external SR
    xe vm-param-set uuid=$VM other-config:XenCenter.CustomFields.backup=daily
    xe vm-param-set uuid=$VM other-config:XenCenter.CustomFields.retain=2

    # Backup using an XVA export to a NFS mount
    xe vm-param-set uuid=$VM other-config:XenCenter.CustomFields.xva_backup=daily
    xe vm-param-set uuid=$VM other-config:XenCenter.CustomFields.xva_retain=2

    # Get current config
    xe vm-param-get uuid=$VM param-name=other-config param-key=XenCenter.CustomFields.backup
    xe vm-param-get uuid=$VM param-name=other-config param-key=XenCenter.CustomFields.retain
    xe vm-param-get uuid=$VM param-name=other-config param-key=XenCenter.CustomFields.xva_backup
    xe vm-param-get uuid=$VM param-name=other-config param-key=XenCenter.CustomFields.xva_retain

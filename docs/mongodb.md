# MongoDB

## General mongoDB commands



## Generic debug command

    db.currentOp();


## Replica Set 

    myreplname:PRIMARY> db.printSlaveReplicationInfo()

    myreplname:PRIMARY> rs.status()

    myreplname:PRIMARY> rs.init()

    myreplname:SECONDARY> db.SlaveOk()

    myreplname:SECONDARY> use admin; db.shutdownServer({timeoutSecs: 300});



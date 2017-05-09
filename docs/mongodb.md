# MongoDB

## Generic debug command

    > db.currentOp();
    > db.serverStatus()
    > db.stats()
    > db.$collection.stats()

## Replica Set 

    > myreplname:PRIMARY> db.printReplicationInfo()

    > myreplname:PRIMARY> db.printSlaveReplicationInfo()

    > myreplname:PRIMARY> rs.status()

    > myreplname:PRIMARY> rs.init()

    > myreplname:SECONDARY> db.SlaveOk()

    > myreplname:SECONDARY> use admin; db.shutdownServer({timeoutSecs: 300});

## Lock/Unlock from writes

    > db._adminCommand({fsync: 1, lock: 1})
    switched to db admin

    > db.$cmd.sys.unlock.findOne()
    { "ok" : 1, "info" : "unlock requested" }
    

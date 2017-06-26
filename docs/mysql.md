# MySQL

## Debug connections problem

    # mysql -e "show status like \"%onn%\";"
    # mysqladmin status
    mysql> show processlist;

## Users

    mysql> CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'newpass';
    mysql> SET PASSWORD FOR 'existinguser'@'localhost' = PASSWORD('existingpass');
    # Generate encrypted version of a password
    mysql> SELECT PASSWORD('mypass');

## Grants

    mysql> SHOW GRANTS FOR 'francis'@'localhost';
    mysql> GRANT ALL ON customer.* TO 'francis'@'localhost' WITH MAX_USER_CONNECTIONS 10;

To change password or resource limits for an existing user, without 
changing privileges

    mysql> GRANT USAGE ON *.* TO 'francis'@'localhost' WITH MAX_USER_CONNECTIONS 10;


## Dumps

    # Only DATA
    mysqldump --skip-opt --skip-create-options --add-locks --no-create-info DBNAME > dump-data-only.sql

    # Disable foreign key checks
    SET AUTOCOMMIT=0;
    SET FOREIGN_KEY_CHECKS=0;

## Mysql Replica

    mysql> GRANT REPLICATION SLAVE ON *.* TO 'slave_user'@'%' IDENTIFIED BY 'password';
    mysql> FLUSH PRIVILEGES;

    mysql> CHANGE MASTER TO 
	MASTER_HOST='12.34.56.789',
	MASTER_USER='slave_user',
	MASTER_PASSWORD='password',
	MASTER_LOG_FILE='mysql-bin.000001',
	MASTER_LOG_POS=107;

Fix single errors on replication:

    mysql> STOP SLAVE; SET GLOBAL SQL_SLAVE_SKIP_COUNTER = 1; SLAVE START;

Free disk space taken by binary logs:

    mysql> PURGE BINARY LOGS BEFORE DATE_SUB( NOW(), INTERVAL 2 DAY );

## InnoDB Compression

    ALTER TABLE <table_name> ENGINE=InnoDB ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=32;



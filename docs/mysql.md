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


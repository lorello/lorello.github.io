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

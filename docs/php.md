# PHP

## Php-fpm
    newrelic.appname = "web30 - liste.lillinet.org"
    post_max_size = 52M
    upload_max_filesize = 52M
    memory_limit = 192M
    catch_workers_output = yes
    log_errors = On
    display_errors = On
    log_level = notice

## Logs everything to file (htaccess format)

    php_flag display_startup_errors on
    php_flag display_errors off
    php_flag html_errors off
    php_flag log_errors on
    #php_flag ignore_repeated_errors off
    #php_flag ignore_repeated_source off
    #php_flag report_memleaks on
    #php_flag track_errors on
    #php_value docref_root 0
    #php_value docref_ext 0
    php_value error_reporting -1
    #php_value log_errors_max_len 0#
    php_value error_log /var/local/www/web1/phperrors.log

This logs sintax erros too, not logged by default in apache error log
or not logged if you're passing options inside the php file itself using
ini_set.



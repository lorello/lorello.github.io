# Nginx

## debugging rewrites rules

Make sure you have `notice` as loglevel of `error_log`

    error_log  /var/log/nginx/www.yoursite.com.error.log notice;
    rewrite_log on;


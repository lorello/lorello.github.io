# Nginx

## Upstream config

    upstream myapp {
        server 127.0.0.1:8081;
    }

    server {
        ...
        location / {
            proxy_pass http://myapp;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header Host $http_host;
        }
    }

## debugging rewrites rules

Make sure you have `notice` as loglevel of `error_log`

    error_log  /var/log/nginx/www.yoursite.com.error.log notice;
    rewrite_log on;


## Rate limiting per calling IP

Under `server` directive

    limit_req_zone $binary_remote_addr zone=mylimit:10m rate=10r/s;
                           (key)       (name):(size)     (max rate)
    limit_req_log_level warn;
    limit_req_status 429
    error_page 429 /error/429.html;


Zone size is in megabytes, consider that state information for about 16,000 IP addresses takes 1 megabyte.


    location /login/ {
        limit_req zone=mylimit burst=20 nodelay;

        proxy_pass http://my_upstream;
    }

The burst parameters is the size of the queue where requests arrived too quickly
are stored.

More details on the [rate limiting manual page](https://www.nginx.com/blog/rate-limiting-nginx/).


## Example of full config

    upstream myapp {
        server 127.0.0.1:8081;
    }

    limit_req_zone $binary_remote_addr zone=login:10m rate=1r/s;

    server {
        listen 443 ssl spdy;
        server_name _;
      
        ssl on;
        ssl_certificate /etc/nginx/ssl/cert.pem;
        ssl_certificate_key /etc/nginx/ssl/cert.key;
        ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
        ssl_ciphers AES256+EECDH:AES256+EDH;
        ssl_session_cache  builtin:1000  shared:SSL:5m;
        ssl_prefer_server_ciphers on;

      
        location / {
            proxy_pass http://myapp;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header Host $http_host;
        }
        
        location /account/login/ {
            # apply rate limiting
            limit_req zone=login burst=5;
        
            # boilerplate copied from location /
            proxy_pass http://myapp;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header Host $http_host;
        }
    }




    docker run -it --rm -p 80:80 sportebois/nginx-rate-limit-sandbox nginx -V 2>&1
    nginx version: nginx/1.11.10
    built by gcc 5.3.0 (Alpine 5.3.0)
    built with OpenSSL 1.0.2k  26 Jan 2017
    TLS SNI support enabled
    configure arguments: --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib/nginx/modules --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --http-client-body-temp-path=/var/cache/nginx/client_temp --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --user=nginx --group=nginx --with-http_ssl_module --with-http_realip_module --with-http_addition_module --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_mp4_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_random_index_module --with-http_secure_link_module --with-http_stub_status_module --with-http_auth_request_module --with-http_xslt_module=dynamic --with-http_image_filter_module=dynamic --with-http_geoip_module=dynamic --with-http_perl_module=dynamic --with-threads --with-stream --with-stream_ssl_module --with-stream_ssl_preread_module --with-stream_realip_module --with-stream_geoip_module=dynamic --with-http_slice_module --with-mail --with-mail_ssl_module --with-compat --with-file-aio --with-http_v2_module
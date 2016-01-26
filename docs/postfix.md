# Postfix mail server

## Debug commands

Who is using the server to send messages?

    find /var/spool/postfix/deferred -type f | xargs -n1 basename | xargs postcat -q | grep 'Authenticated sender'
    find /var/spool/postfix/active -type f | xargs -n1 basename | xargs postcat -q | grep 'Authenticated sender'

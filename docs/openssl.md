# OpenSSL

Create private key

    openssl genrsa -des3 -out server.key 1024

Generate a CSR (Certificate Signing Request)

    openssl req -new -key server.key -out server.csr

Remove Passphrase from Key

    openssl rsa -in server-with-passphrase.key -out server.key

Generating a Self-Signed Certificate

    openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt

Convert x509 to pem

    openssl x509 -inform der -in server.crt -out server.pem

pkcs12 to pem – key only

    openssl pkcs12 -nocerts -in c:\server.pfx -out c:\server-key.key

pkcs12 to pem – certificate only

    openssl pkcs12 -nokeys -in server.pfx -out server-cert.cer

Check a private key

    openssl rsa -in privateKey.key -check

Check a certificate

    openssl x509 -in certificate.crt -text -noout

split pfx file

    openssl pkcs12 -in your.pfx -clcerts -nokeys -out yourcert.pem
    openssl pkcs12 -in your.pfx -nocerts -out yourkey.pem


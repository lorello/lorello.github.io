# Debian/Ubuntu packages

## Recover a config file from original packages

1. Find out what package installed the config file

    $ dpkg -S file.conf

2. Rename (or delete) the config file you wish to restore

3. apt-get -o Dpkg::Options::="--force-confmiss" install --reinstall <package-name>

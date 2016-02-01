# Puppet resources

## Checking code

Puppet syntax checks

    puppet parser validate <file.pp>


Hiera files in YAML format

    ruby -e "require 'yaml'; YAML.parse(File.open('yourhierafile'))"

## Cookbooks

### Make an Exec run one time in N days

    exec { 'update composer':
      command => "wget ${source} -O ${destination}",
              onlyif  => "test `find '${destination}' -mtime +${max_age}`",
              path    => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/'  ],
              require => File[$destination],
    }


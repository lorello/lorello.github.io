# Puppet resources

## Checking code

Puppet syntax checks

    puppet parser validate <file.pp>


Hiera files in YAML format

    ruby -e "require 'yaml'; YAML.parse(File.open('yourhierafile'))"

## Cookbooks

### Validating

    validate_re($ensure, '(present|absent)', "ensure must be 'present' or 'absent', checked value is '$ensure'")

### Making a private class

    if $caller_module_name != $module_name {
      warning("${name} is not part of the public API of the ${module_name} module and should not be directly included in the manifest.")
    }

### Make an Exec run one time in N days

    exec { 'update composer':
      command => "wget ${source} -O ${destination}",
              onlyif  => "test `find '${destination}' -mtime +${max_age}`",
              path    => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/'  ],
              require => File[$destination],
    }

### Validate ensure parameter

    validate_re($ensure, [ '^installed$', '^present$', '^absent$', '^latest$' ])

### Debug Facter && Hiera

    puppet facts find FACTNAME

### Make the resource myresource configurable through hiera hash

    class myclass (
      $values = {},
    ){

      validate_hash($values)

      # ensure merging of hiera levels
      $hiera_values = hiera_hash('myclass::values', {})     # this merge multiple levels
      $real_values = $hiera_values ? {
        undef   => $values,                                 # default values are the class parameter ones
        default => $hiera_values,                           # if exists, hiera values has precedence
      }

      if $real_values {
        create_resources('myresource', $real_values)
      }

### Check for OS family and version

    case $::osfamily {
      'Debian': {
        # do common debian/ubuntu things
        case $::operatingsystem {
          'Debian': {
            if versioncmp($::lsbmajdistrelease, '8') < 0 {
              # do specific things for Debian >= 8
            }
          }
          'Ubuntu': {
            # do specific things for Ubuntu
          }
          default: {
            fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, module ${module_name} only support operatingsystem Debian and Ubuntu on osfamily Debian")
          }
        }
      }
      'RedHat': {
        # do specific things for RedHat
      }
      default: {
        fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, module ${module_name} only support osfamily Debian and RedHat")
      }

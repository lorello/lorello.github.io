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

### Be sure that a class is private

      if $caller_module_name != $module_name {
           fail("Use of private class ${name} by ${caller_module_name}")
      }

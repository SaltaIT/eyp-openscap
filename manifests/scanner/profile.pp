define openscap::scanner::profile (
                                    $profile_name = $name,
                                    $ensure       = 'present',
                                    $source       = undef,
                                    $source_url   = undef,
                                  ) {

  include openscap::scanner

  if($source!=undef and $source_url!=undef)
  {
    fail('source and source_url cannot be both defined for the same resource')
  }

  if($source!=undef)
  {
    file { "${openscap::scanner::basedir}/profiles/${profile_name}.xml":
      ensure  => $ensure,
      owner   => 'root',
      group   => 'root',
      mode    => '0640',
      require => File["${openscap::scanner::basedir}/profiles"],
      source  => $source,
    }
  }
  elsif($source_url!=undef)
  {
    exec { "which wget oscap scanner profile ${profile_name}":
      command => 'which wget',
      unless  => 'which wget',
    }

    exec { "wget ${profile_name}":
      command => "wget ${source_url} -O ${openscap::scanner::basedir}/profiles/${profile_name}.xml",
      creates => "${openscap::scanner::basedir}/profiles/${profile_name}.xml",
      require => [
                    File["${openscap::scanner::basedir}/profiles"],
                    Exec["which wget oscap scanner profile ${profile_name}"]
                  ],
    }

    file { "${openscap::scanner::basedir}/profiles/${profile_name}.xml":
      ensure  => $ensure,
      owner   => 'root',
      group   => 'root',
      mode    => '0640',
      require => Exec["wget ${profile_name}"],
    }
  }
  else
  {
    fail('either source or source_url must be defined')
  }
}

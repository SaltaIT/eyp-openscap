class openscap::scanner::install inherits openscap::scanner {

  Exec {
    path => '/usr/sbin:/usr/bin:/sbin:/bin',
  }

  if($openscap::scanner::manage_package)
  {
    package { $openscap::params::scanner_package_name:
      ensure => $openscap::scanner::package_ensure,
    }
  }

  exec { "openscap scanner mkdir -p ${openscap::basedir}":
    command => "mkdir -p ${openscap::basedir}",
    creates => $openscap::basedir,
  }

  file { $openscap::basedir:
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
    require => Exec["openscap scanner mkdir -p ${openscap::basedir}"],
  }

  exec { "openscap scanner mkdir -p ${openscap::basedir}/profiles":
    command => "mkdir -p ${openscap::basedir}/profiles",
    creates => "${openscap::basedir}/profiles",
  }

  file { "${openscap::basedir}/profiles":
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
    require => Exec["openscap scanner mkdir -p ${openscap::basedir}/profiles"],
  }

}

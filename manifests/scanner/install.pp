class openscap::scanner::install inherits openscap::scanner {

  if($openscap::scanner::manage_package)
  {
    package { $openscap::params::scanner_package_name:
      ensure => $openscap::scanner::package_ensure,
    }
  }

}

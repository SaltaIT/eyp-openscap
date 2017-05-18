class openscap::install inherits openscap {

  if($openscap::manage_package)
  {
    package { $openscap::params::package_name:
      ensure => $openscap::package_ensure,
    }
  }

}

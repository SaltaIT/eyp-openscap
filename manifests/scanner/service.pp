class openscap::scanner::service inherits openscap::scanner {

  #
  validate_bool($openscap::scanner::manage_docker_service)
  validate_bool($openscap::scanner::manage_service)
  validate_bool($openscap::scanner::service_enable)

  validate_re($openscap::scanner::service_ensure, [ '^running$', '^stopped$' ], "Not a valid daemon status: ${openscap::service_ensure}")

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $openscap::scanner::manage_docker_service)
  {
    if($openscap::scanner::manage_service)
    {
      service { $openscap::params::service_name:
        ensure => $openscap::scanner::service_ensure,
        enable => $openscap::scanner::service_enable,
      }
    }
  }
}

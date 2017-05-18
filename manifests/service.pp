class openscap::service inherits openscap {

  #
  validate_bool($openscap::manage_docker_service)
  validate_bool($openscap::manage_service)
  validate_bool($openscap::service_enable)

  validate_re($openscap::service_ensure, [ '^running$', '^stopped$' ], "Not a valid daemon status: ${openscap::service_ensure}")

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $openscap::manage_docker_service)
  {
    if($openscap::manage_service)
    {
      service { $openscap::params::service_name:
        ensure => $openscap::service_ensure,
        enable => $openscap::service_enable,
      }
    }
  }
}

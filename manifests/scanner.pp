class openscap::scanner(
                $manage_package        = true,
                $package_ensure        = 'installed',
                $manage_service        = true,
                $manage_docker_service = true,
                $service_ensure        = 'running',
                $service_enable        = true,
              ) inherits openscap::params{

  validate_re($package_ensure, [ '^present$', '^installed$', '^absent$', '^purged$', '^held$', '^latest$' ], 'Not a supported package_ensure: present/absent/purged/held/latest')

  class { '::openscap::scanner::install': }
  -> class { '::openscap::scanner::config': }
  ~> class { '::openscap::scanner::service': }
  -> Class['::openscap::scanner']

}

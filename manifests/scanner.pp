class openscap::scanner (
                          $manage_package = true,
                          $package_ensure = 'installed',
                          $basedir        = '/opt/openscap',
                        ) inherits openscap::params{

  validate_re($package_ensure, [ '^present$', '^installed$', '^absent$', '^purged$', '^held$', '^latest$' ], 'Not a supported package_ensure: present/absent/purged/held/latest')

  class { '::openscap::scanner::install': }
  -> class { '::openscap::scanner::config': }
  -> Class['::openscap::scanner']

}

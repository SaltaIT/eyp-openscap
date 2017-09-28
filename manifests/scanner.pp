#
# @param manage_package Controls whether the openscap package is managed or not (default: true)
# @param package_ensure Package ensure (default: installed)
# @param basedir OpenSCAP scanner installation basedir (default: /opt/openscap)
# @param basedir_owner basedir owner (default: root)
# @param basedir_group basedir group (default: root)
# @param basedir_mode basedir mode (default: 0700)
# @param results_mode results dir mode (default: 0700)
# @param reports_mode reports dir mode (default: 0700)
#
class openscap::scanner (
                          $manage_package = true,
                          $package_ensure = 'installed',
                          $basedir        = '/opt/openscap',
                          $basedir_owner  = 'root',
                          $basedir_group  = 'root',
                          $basedir_mode   = '0700',
                          $results_mode   = '0700',
                          $reports_mode   = '0700',
                        ) inherits openscap::params{

  validate_re($package_ensure, [ '^present$', '^installed$', '^absent$', '^purged$', '^held$', '^latest$' ], 'Not a supported package_ensure: present/absent/purged/held/latest')

  class { '::openscap::scanner::install': }
  -> class { '::openscap::scanner::config': }
  -> Class['::openscap::scanner']

}

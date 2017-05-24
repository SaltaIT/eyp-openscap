class openscap::params {

  $scanner_package_name=[ 'openscap-scanner', 'scap-security-guide' ]
  $service_name='openscap'

  case $::osfamily
  {
    'redhat':
    {
      case $::operatingsystem
      {
          'CentOS':
          {
            case $::operatingsystemrelease
            {
              /^7.*$/:
              {
                $xccdf = '/usr/share/xml/scap/ssg/content/ssg-centos7-xccdf.xml'
                $xccdf_cpe = '/usr/share/xml/scap/ssg/content/ssg-rhel7-cpe-dictionary.xml'
              }
              default: { fail("Unsupported CentOS version! - ${::operatingsystemrelease}")  }
            }
          }
          default: { fail('unsupported RH flavor')}
      }
    }
    'Debian':
    {
      case $::operatingsystem
      {
        'Ubuntu':
        {
          case $::operatingsystemrelease
          {
            /^14.*$/:
            {
            }
            /^16.*$/:
            {
            }
            default: { fail("Unsupported Ubuntu version! - ${::operatingsystemrelease}")  }
          }
        }
        'Debian': { fail('Unsupported')  }
        default: { fail('Unsupported Debian flavour!')  }
      }
    }
    default: { fail('Unsupported OS!')  }
  }
}

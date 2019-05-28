# ---
# classes:
#   - openscap::scanner
# openscapscannerxccdfs:
#   'demo':
#     profile: 'demo_basic_security_profile'
#     hour: '14'
#     minute: '40'
# openscapscannerprofiles:
#   'demo_basic_security_profile':
#     source: 'puppet:///customers/MORPHO-KENYA_7787c3ee034e/demo_basic_security_profile.xml'

class { 'openscap::scanner':
  basedir_mode => '0755',
  results_mode => '0755',
  reports_mode => '0755',
}

openscap::scanner::xccdf { 'demo':
  profile => 'cis_subset',
  hour    => '0',
  minute  => '0',
}

openscap::scanner::profile { 'cis_subset':
  content => file('openscap/cis_subset.xml'),
}

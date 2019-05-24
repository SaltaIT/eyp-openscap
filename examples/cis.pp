# ---
# classes:
#   - openscap::scanner
# openscapscannerxccdfs:
#   'scytl':
#     profile: 'scytl_basic_security_profile'
#     hour: '14'
#     minute: '40'
# openscapscannerprofiles:
#   'scytl_basic_security_profile':
#     source: 'puppet:///customers/MORPHO-KENYA_7787c3ee034e/scytl_basic_security_profile.xml'

class { 'openscap::scanner':
  basedir_mode => '0755',
  results_mode => '0755',
  reports_mode => '0755',
}

#
# oscap xccdf eval --remediate --profile systemadmin_basic_security_profile \
#       --results /tmp/oscap/systemadmin_basic_security_profile.xml
#       --report /tmp/oscap/systemadmin_basic_security_profile.html
#       --tailoring-file /tmp/systemadmin_basic_security_profile.xml
#       --cpe /usr/share/xml/scap/ssg/content/ssg-rhel7-cpe-dictionary.xml
#       /usr/share/xml/scap/ssg/content/ssg-centos7-xccdf.xml
#
define openscap::scanner::xccdf (
                                  $remediate = false,
                                ) {

  include openscap::scanner


}

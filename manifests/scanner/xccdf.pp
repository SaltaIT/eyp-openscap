#
# eXtensible Configuration Checklist Description Format
#
# oscap xccdf eval --remediate --profile systemadmin_basic_security_profile \
#       --results /tmp/oscap/systemadmin_basic_security_profile.xml
#       --report /tmp/oscap/systemadmin_basic_security_profile.html
#       --tailoring-file /tmp/systemadmin_basic_security_profile.xml
#       --cpe /usr/share/xml/scap/ssg/content/ssg-rhel7-cpe-dictionary.xml
#       /usr/share/xml/scap/ssg/content/ssg-centos7-xccdf.xml
#
# [root@centos7 tmp]# ls /usr/share/xml/scap/ssg/content/ -la
# total 12868
# drwxr-xr-x. 2 root root    4096 May 24 16:28 .
# drwxr-xr-x. 3 root root      20 May 24 16:28 ..
# -rw-r--r--. 1 root root 4760829 Mar  3 11:49 ssg-centos6-ds.xml
# -rw-r--r--. 1 root root 4976999 Mar  3 11:48 ssg-centos7-ds.xml
# -rw-r--r--. 1 root root 1583741 Mar  3 11:48 ssg-centos7-xccdf.xml
# -rw-r--r--. 1 root root  267074 Mar  3 11:49 ssg-firefox-ds.xml
# -rw-r--r--. 1 root root  169303 Mar  3 11:49 ssg-jre-ds.xml
# -rw-r--r--. 1 root root    2204 Mar  3 11:48 ssg-rhel7-cpe-dictionary.xml
# -rw-r--r--. 1 root root   16689 Mar  3 11:48 ssg-rhel7-cpe-oval.xml
# -rw-r--r--. 1 root root 1373831 Mar  3 11:48 ssg-rhel7-oval.xml
#
# PCI-DSS
# oscap xccdf eval --report pci-dss-anaconda-report.html \
#                   --profile xccdf_org.ssgproject.content_profile_pci-dss \
#                   /usr/share/xml/scap/ssg/content/ssg-rhel7-ds.xml
#
#
define openscap::scanner::xccdf (
                                  $profile,
                                  $xccdf_name                  = $name,
                                  $ensure                      = 'present',
                                  $remediate                   = false,
                                  $fetch_remote_resources      = true,
                                  $hour                        = '2',
                                  $minute                      = '0',
                                  $month                       = undef,
                                  $monthday                    = undef,
                                  $weekday                     = undef,
                                  $setcron                     = true,
                                  $generate_remediation_script = true,
                                  $tailoring                   = true,
                                  $cpe                         = true,
                                  $ds                          = false,
                                ) {

  include openscap::scanner

  file { "${openscap::scanner::basedir}/xccdf/${xccdf_name}.sh":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0500',
    content => template("${module_name}/xccdf.erb"),
  }

  if($setcron)
  {
    cron { "cronjob openscap xccdf ${xccdf_name}":
      command  => "${openscap::scanner::basedir}/xccdf/${xccdf_name}.sh",
      user     => 'root',
      hour     => $hour,
      minute   => $minute,
      month    => $month,
      monthday => $monthday,
      weekday  => $weekday,
      require  => File["${openscap::scanner::basedir}/xccdf/${xccdf_name}.sh"],
    }
  }

}

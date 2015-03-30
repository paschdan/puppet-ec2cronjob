# == Class ec2cronjob::install
#
# This class is called from ec2cronjob for install.
#
class ec2cronjob::install {

  package { $::ec2cronjob::package_name:
    ensure => present,
  }
}

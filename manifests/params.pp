# == Class ec2cronjob::params
#
# This class is meant to be called from ec2cronjob.
# It sets variables according to platform.
#
class ec2cronjob::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'ec2cronjob'
      $service_name = 'ec2cronjob'
    }
    'RedHat', 'Amazon': {
      $package_name = 'ec2cronjob'
      $service_name = 'ec2cronjob'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}

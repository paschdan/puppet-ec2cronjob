# == Class ec2cronjob::service
#
# This class is meant to be called from ec2cronjob.
# It ensure the service is running.
#
class ec2cronjob::service {

  service { $::ec2cronjob::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}

# == Class: ec2cronjob
#
# Full description of class ec2cronjob here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class ec2cronjob (
  $package_name = $::ec2cronjob::params::package_name,
  $service_name = $::ec2cronjob::params::service_name,
) inherits ::ec2cronjob::params {

  # validate parameters here

  class { '::ec2cronjob::install': } ->
  class { '::ec2cronjob::config': } ~>
  class { '::ec2cronjob::service': } ->
  Class['::ec2cronjob']
}

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
  $aws_access_key_id     = $::ec2cronjob::params::aws_access_key_id,
  $aws_secret_access_key = $::ec2cronjob::params::aws_secret_access_key,
) inherits ::ec2cronjob::params {

  # validate parameters here

  class { '::ec2cronjob::install': } ->
  Class['::ec2cronjob']
}

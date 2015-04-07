# == Class ec2cronjob::params
#
# This class is meant to be called from ec2cronjob.
# It sets variables according to platform.
#
class ec2cronjob::params {
  $aws_access_key_id = undef
  $aws_secret_access_key = undef
}

# == Class ec2cronjob::install
#
# This class is called from ec2cronjob for install.
#
class ec2cronjob::install {

  file {'/opt/ec2crons':
    ensure => 'directory'
  }

  if ($ec2cronjob::aws_access_key_id != undef) and ($ec2cronjob::aws_secret_access_key != undef) {
  # Install awscli
  include '::awscli'
  # Install awscli profile when data is given
    awscli::profile {
      'default':
        aws_access_key_id     => $ec2cronjob::aws_access_key_id,
        aws_secret_access_key => $ec2cronjob::aws_secret_access_key
    }
  }

}

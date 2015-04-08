# == Class ec2cronjob::install
#
# This class is called from ec2cronjob for install.
#
class ec2cronjob::install {

  # Install awscli
  include '::awscli'
  # Install awscli profile when data is given

  file {'/opt/ec2crons':
    ensure => 'directory'
  }

  if ($ec2cronjob::aws_secret_access_key != undef) and ($ec2cronjob::aws_secret_access_key != undef) {
    awscli::profile {
      'default':
        aws_access_key_id     => $ec2cronjob::aws_access_key_id,
        aws_secret_access_key => $ec2cronjob::aws_secret_access_key
    }
  }

}

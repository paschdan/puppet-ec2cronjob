# == Define: ec2cronjob::cron
#
# Adds a Cronjob to the system that is only running on once instance per ami
#
# === Options
#
# [*ensure*]
#   Either absent or present
# [*command*]
#  The Command to execute

define ec2cronjob::cron(
  $ensure   = 'present',
  $command  = undef,
  $hour     = undef,
  $minute   = undef,
  $month    = undef,
  $monthday = undef,
  $weekday  = undef
) {

  include '::ec2cronjob'

  if $::ec2_instance_id == undef {
    fail('not inside aws, cannot create')
  }

  validate_re(
    $ensure,
    '^(present|absent)$',
    "${ensure} is not supported for ensure. Allowed values are 'present' and 'absent'."
  )

  if $command == undef {
    fail('no command specified, cannot create')
  }

  validate_string(
    $command,
    'command appears not to be a string'
  )

  file { "/opt/ec2crons/${title}.sh":
    ensure  => 'present',
    content => template('ec2cronjob/wrapper.sh.erb')
  }

  cron { $title:
    ensure   => 'present',
    command  => "/opt/ec2crons/${title}.sh",
    hour     => $hour,
    minute   => $minute,
    month    => $month,
    monthday => $monthday,
    weekday  => $weekday
  }
}

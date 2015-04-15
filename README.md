[![Puppet Forge](https://img.shields.io/puppetforge/v/paschdan/ec2cronjob.svg)](https://forge.puppetlabs.com/paschdan/ec2cronjob)
[![Build Status](https://travis-ci.org/asgoodasnu/puppet-ec2cronjob.svg)](https://travis-ci.org/asgoodasnu/puppet-ec2cronjob)
[![wercker status](https://app.wercker.com/status/430494f38e61c46e948dcd39b6f3f6d8/s/master "wercker status")](https://app.wercker.com/project/bykey/430494f38e61c46e948dcd39b6f3f6d8)
[![Puppet Forge](https://img.shields.io/puppetforge/dt/paschdan/ec2cronjob.svg)]()

## Overview

This module can generate CRON-JOBS that runs on only one EC2-Instance based on the used AMI.

To be able to do this it installs the awscli tools.

Until jdowning releases a newer version of his [awscli](https://forge.puppetlabs.com/jdowning/awscli)
you need to use master branch !!!!

## How does it work

This module installs a wrapper script around your cronjob.
This wrapper does the following:

* it gets the instance-id of the mashine via facter
* it gets the ami-id of the mashine via facter
* it gets the region of the mashine via facter / sed
* it gets the first instance with the current ami in the current region via awscli
* it runs your cronjob if the first instance (from awscli) is the same as the current instance

### Usage


#### Add a Cron

if you are using awscli with my profiles-fix you can use it this way:

add an awscli profile for root user and prepare system for adding crons

```
class { 'ec2cronjob':
  aws_access_key_id     => 'MYACCESSKEYID'
  aws_secret_access_key => 'MYSECRETACCESSKEY'
}
```

to add a cron simply do

```
ec2cronjob::cron { 'mytestcron':
  command  => 'echo "Hello World"',
  minute   => 1,
  hour     => 2,
  weekday  => 4,
  month    => 5,
  monthday => 7
}
```

you will need installed awscli (with credentials) to have the cronjob running.

#### Remove a Cron

```
ec2cronjob::cron { 'mytestcron':
  ensure => absent
}
```

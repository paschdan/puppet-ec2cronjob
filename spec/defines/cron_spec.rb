require 'spec_helper'

describe 'ec2cronjob::cron' do
  context 'on debian system' do
    let :facts do
      {
        :osfamily => 'Debian'
      }
    end

    let (:title) { 'test_job' }

    let(:params) { { } }

    it 'should fail when we are not in aws' do
      is_expected.to raise_error(Puppet::Error, /not inside aws, cannot create/)
    end

    describe 'inside aws' do

      let(:facts) { {
        :osfamily => 'Debian',
        :ec2_ami_id => 'ami-12345',
        :ec2_instance_id => 'i-123456',
        :ec2_instance_type => 't2.micro',
        :ec2_placement_availability_zone => 'eu-test-1a'
      } }


      it 'should fail when ensure is not present or absent' do
        params.merge!({
          'ensure' => 'invalid_val'
        })
        is_expected.to raise_error(Puppet::Error, /invalid_val is not supported for ensure\. Allowed values are 'present' and 'absent'\./)
      end

      it 'should fail when no command is specified' do
        is_expected.to raise_error(Puppet::Error, /no command specified, cannot create/)
      end

      it 'should fail when command is not a string' do
        params.merge!({
          'command' => ['this', 'is', 'an', 'array']
        })
        is_expected.to raise_error(Puppet::Error, /is not a string/)
      end

      context 'with correct params' do
        let (:params) { {
          'ensure' => 'present',
          'command' => '/bin/false'
        }}

        it 'should create the bash wrapper' do
          is_expected.to contain_file('/opt/ec2crons/test_job.sh').with({
            :ensure => 'present',
            :content => /#Ec2CronJob: test_job/,
            :content => /LOCAL_AMI=ami-12345/,
            :content => /LOCAL_IID=i-123456/,
            :content => /LOCAL_AZ=eu-test-1a/
          })
        end

        it 'should create a cron' do
          is_expected.to contain_cron('test_job').with(
            'ensure' => 'present',
            'command' => '/opt/ec2crons/test_job.sh'
          )
        end
      end
      context 'with hour given' do
        let (:params) { {
          'ensure' => 'present',
          'command' => '/bin/false',
          'hour' => 3
        } }
        it 'should create a cron with hour set to 3' do
          is_expected.to contain_cron('test_job').with(
            'ensure' => 'present',
            'command' => '/opt/ec2crons/test_job.sh',
            'hour' => 3
          )
        end
      end
      context 'with minute given' do
        let (:params) { {
          'ensure' => 'present',
          'command' => '/bin/false',
          'minute' => 5
        } }
        it 'should create a cron with minute set to 5' do
          is_expected.to contain_cron('test_job').with(
            'ensure' => 'present',
            'command' => '/opt/ec2crons/test_job.sh',
            'minute' => 5
          )
        end
      end
      context 'with month given' do
        let (:params) { {
          'ensure' => 'present',
          'command' => '/bin/false',
          'month' => 7
        } }
        it 'should create a cron with month set to 7' do
          is_expected.to contain_cron('test_job').with(
            'ensure' => 'present',
            'command' => '/opt/ec2crons/test_job.sh',
            'month' => 7
          )
        end
      end
      context 'with monthday given' do
        let (:params) { {
          'ensure' => 'present',
          'command' => '/bin/false',
          'monthday' => 9
        } }
        it 'should create a cron with monthday set to 9' do
          is_expected.to contain_cron('test_job').with(
            'ensure' => 'present',
            'command' => '/opt/ec2crons/test_job.sh',
            'monthday' => 9
          )
        end
      end
      context 'with weekday given' do
        let (:params) { {
          'ensure' => 'present',
          'command' => '/bin/false',
          'weekday' => 5
        } }
        it 'should create a cron with monthday set to 9' do
          is_expected.to contain_cron('test_job').with(
            'ensure' => 'present',
            'command' => '/opt/ec2crons/test_job.sh',
            'weekday' => 5
          )
        end
      end
    end
  end
end

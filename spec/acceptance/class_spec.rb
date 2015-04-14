require 'spec_helper_acceptance'

describe 'ec2cronjob class' do

  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      ec2cronjob::cron { 'mytest':
        command => '/bin/false',
        hour => 1,
        minute => 2,
        month => 3,
        monthday => 4,
        weekday => 5
      }
      EOS

      facts = {
        'FACTER_ec2_instance_id' => 'i-1234567',
        'FACTER_ec2_ami_id' => 'ami-1234567',
        'FACTER_ec2_placement_availability_zone' => 'eu-test-1a'
      }

      # Run it twice and test for id should eq 0empotency
      apply_manifest(pp, :catch_failures => true, :environment => facts)
      apply_manifest(pp, :catch_changes  => true, :environment => facts)
    end

    describe command('pip --version') do
      its(:exit_status) { should eq 0 }
    end

    describe command('aws --version') do
      its(:exit_status) { should eq 0}
    end

    describe file('/opt/ec2crons/mytest.sh') do
      it { should be_file }
      its(:content) { should match /Ec2CronJob: mytest/ }
      its(:content) { should match /LOCAL_AMI=ami-1234567/ }
      its(:content) { should match /LOCAL_IID=i-1234567/ }
      its(:content) { should match /LOCAL_AZ=eu-test-1a/ }
      its(:content) { should match /\s{2}\/bin\/false/ }
    end

    describe cron do
      it { should have_entry '2 1 4 3 5 /opt/ec2crons/mytest.sh' }
    end
  end
end

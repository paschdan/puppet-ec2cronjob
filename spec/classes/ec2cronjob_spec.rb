require 'spec_helper'

describe 'ec2cronjob', :type => :class do
  context "on a Debian OS" do
    let :debian_facts do
      {
        :osfamily => 'Debian'
      }
    end
    let :facts do {}.merge debian_facts end
    it { is_expected.to contain_class("ec2cronjob::params") }
    it { is_expected.to contain_class("ec2cronjob::install") }
    it { is_expected.to contain_class("awscli")}
    it { is_expected.to contain_file("/opt/ec2crons").with({
      :ensure => 'directory'
    })}
    context "with aws credentials" do
      let :facts do
        {
          :concat_basedir => '/tmp/'
        }.merge debian_facts
      end
      let :params do
        {
          :aws_access_key_id => 'MYAWSACCESSKEYID',
          :aws_secret_access_key => 'MYAESSECRETACCESSKEY'
        }
      end
      it { is_expected.to contain_awscli__profile("default").with(
        'aws_access_key_id' => 'MYAWSACCESSKEYID',
        'aws_secret_access_key' => 'MYAESSECRETACCESSKEY'
      )
      }
    end
  end
end

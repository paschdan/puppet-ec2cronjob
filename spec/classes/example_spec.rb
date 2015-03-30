require 'spec_helper'

describe 'ec2cronjob' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "ec2cronjob class without any parameters" do
          let(:params) {{ }}

          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('ec2cronjob::params') }
          it { is_expected.to contain_class('ec2cronjob::install').that_comes_before('ec2cronjob::config') }
          it { is_expected.to contain_class('ec2cronjob::config') }
          it { is_expected.to contain_class('ec2cronjob::service').that_subscribes_to('ec2cronjob::config') }

          it { is_expected.to contain_service('ec2cronjob') }
          it { is_expected.to contain_package('ec2cronjob').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'ec2cronjob class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { is_expected.to contain_package('ec2cronjob') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end

require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'

unless ENV['BEAKER_provision'] == 'no'
  hosts.each do |host|
    # Install Puppet
    if host.is_pe?
      install_pe
    else
      install_puppet
    end
  end
end


RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    # Install module and dependencies
    hosts.each do |host|
      on host, 'rm -rf /etc/puppet/modules/*'
      #install stdlib
      on host, puppet('module install puppetlabs-stdlib'), { :acceptable_exit_codes => [0,1] }
      on host, puppet('module install puppetlabs-concat'), { :acceptable_exit_codes => [0,1] }

      #install git
      if !host.check_for_command 'git'
        install_package host, 'git'
      end
      on host, '[ -d "/etc/puppet/modules/awscli" ] || git clone git://github.com/asgoodasnu/puppet-awscli.git /etc/puppet/modules/awscli'
    end
    puppet_module_install(:source => proj_root, :module_name => 'ec2cronjob')
  end
end

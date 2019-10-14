case os.release.to_i
when 8
  describe package('yum-cron') do
    it { should_not be_installed }
  end

  describe service('yum-cron') do
    it { should_not be_enabled }
    it { should_not be_running }
  end

  describe file('/etc/sysconfig/yum-cron') do
    it { should_not exist }
  end

  %w(daily hourly).each do |i|
    describe file("/etc/cron.#{i}/0yum-#{i}.cron") do
      it { should_not exist }
    end
  end

  %w(yum-cron yum-cron-hourly).each do |file|
    describe file("/etc/yum/#{file}.conf") do
      it { should_not exist }
    end
  end
when 7
  describe package('yum-cron') do
    it { should be_installed }
  end

  describe service('yum-cron') do
    it { should be_enabled }
    it { should be_running }
  end

  %w(daily hourly).each do |i|
    describe file("/etc/cron.#{i}/0yum-#{i}.cron") do
      it { should be_file }
      it { should be_executable }
    end
  end

  %w(yum-cron yum-cron-hourly).each do |file|
    describe ini("/etc/yum/#{file}.conf") do
      its('commands.update_cmd') { should match 'default' }
      its('emitters.system_name') { should match 'None' }
      its('emitters.emit_via') { should match 'stdio' }
      its('emitters.output_width') { should match '80' }
      its('email.email_from') { should match 'root@localhost' }
      its('email.email_to') { should match 'root' }
      its('email.email_host') { should match 'localhost' }
      its('groups.group_list') { should match 'None' }
      its('groups.group_package_types') { should match 'mandatory, default' }
      its('base.debuglevel') { should match '-2' }
      its('base.skip_broken') { should match 'False' }
      its('base.mdpolicy') { should match 'group:main' }
      its('base.assumeyes') { should match 'False' }
    end
  end

  describe ini('/etc/yum/yum-cron.conf') do
    its('commands.update_messages') { should match 'yes' }
    its('commands.download_updates') { should match 'yes' }
    its('commands.apply_updates') { should match 'yes' }
    its('commands.random_sleep') { should match '360' }
  end

  describe ini('/etc/yum/yum-cron-hourly.conf') do
    its('commands.update_messages') { should match 'no' }
    its('commands.download_updates') { should match 'no' }
    its('commands.apply_updates') { should match 'no' }
    its('commands.random_sleep') { should match '15' }
  end
when 6
  describe package('yum-cron') do
    it { should be_installed }
  end

  describe service('yum-cron') do
    it { should be_enabled }
    it { should be_running }
  end

  describe file('/etc/cron.daily/0yum.cron') do
    it { should be_file }
    it { should be_executable }
  end

  describe file('/etc/sysconfig/yum-cron') do
    its('content') { should match /CHECK_ONLY="no"/ }
    its('content') { should match /CHECK_FIRST="no"/ }
    its('content') { should match /DOWNLOAD_ONLY="no"/ }
    its('content') { should match /ERROR_LEVEL="0"/ }
    its('content') { should match /DEBUG_LEVEL="0"/ }
    its('content') { should match /RANDOMWAIT="60"/ }
    its('content') { should match /MAILTO="root"/ }
    its('content') { should match /SYSTEMNAME=""/ }
    its('content') { should match /DAYS_OF_WEEK="0123456"/ }
    its('content') { should match /CLEANDAY="0"/ }
    its('content') { should match /SERVICE_WAITS="yes"/ }
    its('content') { should match /SERVICE_WAIT_TIME="300"/ }
  end
end

describe service('yum-cron') do
  it { should be_enabled }
  it { should be_running }
end

if os.release < '7.0'
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
else
  %w(daily hourly).each do |i|
    describe file("/etc/cron.#{i}/0yum-#{i}.cron") do
      it { should be_file }
      it { should be_executable }
    end
  end

  %w(yum-cron yum-cron-hourly).each do |file|
    describe file("/etc/yum/#{file}.conf") do
      its('content') { should match /update_cmd = default/ }
      its('content') { should match /system_name = None/ }
      its('content') { should match /emit_via = stdio/ }
      its('content') { should match /output_width = 80/ }
      its('content') { should match /email_from = root@localhost/ }
      its('content') { should match /email_to = root/ }
      its('content') { should match /email_host = localhost/ }
      its('content') { should match /group_list = None/ }
      its('content') { should match /group_package_types = mandatory, default/ }
      its('content') { should match /debuglevel = -2/ }
      its('content') { should match /skip_broken = False/ }
      its('content') { should match /mdpolicy = group:main/ }
      its('content') { should match /assumeyes = False/ }
    end
  end

  describe file('/etc/yum/yum-cron.conf') do
    its('content') { should match /update_messages = yes/ }
    its('content') { should match /download_updates = yes/ }
    its('content') { should match /apply_updates = yes/ }
    its('content') { should match /random_sleep = 360/ }
  end

  describe file('/etc/yum/yum-cron-hourly.conf') do
    its('content') { should match /update_messages = no/ }
    its('content') { should match /download_updates = no/ }
    its('content') { should match /apply_updates = no/ }
    its('content') { should match /random_sleep = 15/ }
  end
end

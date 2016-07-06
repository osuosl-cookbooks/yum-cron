case node['platform_version'].to_i
when 6
  default['yum-cron']['check_first'] = 'no'
  default['yum-cron']['check_only'] = 'no'
  default['yum-cron']['cleanday'] = 0
  default['yum-cron']['daily_conf'] = '/etc/sysconfig/yum-cron'
  default['yum-cron']['days_of_week'] = '0123456'
  default['yum-cron']['debug_level'] = 0
  default['yum-cron']['download_only'] = 'no'
  default['yum-cron']['error_level'] = 0
  default['yum-cron']['mailto'] = 'root'
  default['yum-cron']['randomwait'] = 60
  default['yum-cron']['service_waits'] = 'yes'
  default['yum-cron']['service_wait_time'] = 300
  default['yum-cron']['systemname'] = nil
  default['yum-cron']['yum_parameter'] = nil
when 7
  default['yum-cron']['daily_conf'] = '/etc/yum/yum-cron.conf'
  default['yum-cron']['hourly_conf'] = '/etc/yum/yum-cron-hourly.conf'
  default['yum-cron']['daily']['commands'] = {
    'update_cmd' => 'default',
    'update_messages' => 'yes',
    'download_updates' => 'yes',
    'apply_updates' => 'yes',
    'random_sleep' => 360
  }
  default['yum-cron']['daily']['emitters'] = {
    'system_name' => 'None',
    'emit_via' => 'stdio',
    'output_width' => 80
  }
  default['yum-cron']['daily']['email'] = {
    'email_from' => 'root@localhost',
    'email_to' => 'root',
    'email_host' => 'localhost'
  }
  default['yum-cron']['daily']['groups'] = {
    'group_list' => 'None',
    'group_package_types' => 'mandatory, default'
  }
  default['yum-cron']['daily']['base'] = {
    'debuglevel' => '-2',
    'skip_broken' => 'False',
    'mdpolicy' => 'group:main',
    'assumeyes' => 'False'
  }
  default['yum-cron']['hourly']['commands'] = {
    'update_cmd' => 'default',
    'update_messages' => 'no',
    'download_updates' => 'no',
    'apply_updates' => 'no',
    'random_sleep' => 15
  }
  default['yum-cron']['hourly']['emitters'] = {
    'system_name' => 'None',
    'emit_via' => 'stdio',
    'output_width' => 80
  }
  default['yum-cron']['hourly']['email'] = {
    'email_from' => 'root@localhost',
    'email_to' => 'root',
    'email_host' => 'localhost'
  }
  default['yum-cron']['hourly']['groups'] = {
    'group_list' => 'None',
    'group_package_types' => 'mandatory, default'
  }
  default['yum-cron']['hourly']['base'] = {
    'debuglevel' => '-2',
    'skip_broken' => 'False',
    'mdpolicy' => 'group:main',
    'assumeyes' => 'False'
  }
end

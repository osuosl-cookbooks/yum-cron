default['yum-cron']['daily_conf'] = '/etc/yum/yum-cron.conf'
default['yum-cron']['hourly_conf'] = '/etc/yum/yum-cron-hourly.conf'
default['yum-cron']['daily']['commands'] = {
  'update_cmd' => 'default',
  'update_messages' => 'yes',
  'download_updates' => 'yes',
  'apply_updates' => 'yes',
  'random_sleep' => 360,
}
default['yum-cron']['daily']['emitters'] = {
  'system_name' => 'None',
  'emit_via' => 'stdio',
  'output_width' => 80,
}
default['yum-cron']['daily']['email'] = {
  'email_from' => 'root@localhost',
  'email_to' => 'root',
  'email_host' => 'localhost',
}
default['yum-cron']['daily']['groups'] = {
  'group_list' => 'None',
  'group_package_types' => 'mandatory, default',
}
default['yum-cron']['daily']['base'] = {
  'debuglevel' => '-2',
  'skip_broken' => 'False',
  'mdpolicy' => 'group:main',
  'assumeyes' => 'False',
}
default['yum-cron']['hourly']['commands'] = {
  'update_cmd' => 'default',
  'update_messages' => 'no',
  'download_updates' => 'no',
  'apply_updates' => 'no',
  'random_sleep' => 15,
}
default['yum-cron']['hourly']['emitters'] = {
  'system_name' => 'None',
  'emit_via' => 'stdio',
  'output_width' => 80,
}
default['yum-cron']['hourly']['email'] = {
  'email_from' => 'root@localhost',
  'email_to' => 'root',
  'email_host' => 'localhost',
}
default['yum-cron']['hourly']['groups'] = {
  'group_list' => 'None',
  'group_package_types' => 'mandatory, default',
}
default['yum-cron']['hourly']['base'] = {
  'debuglevel' => '-2',
  'skip_broken' => 'False',
  'mdpolicy' => 'group:main',
  'assumeyes' => 'False',
}

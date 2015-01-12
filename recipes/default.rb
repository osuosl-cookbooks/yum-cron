#
# Cookbook Name:: yum-cron
# Recipe:: default
# Author:: Oregon State University (<chef@osuosl.org>)
#
# Copyright (C) 2015 Oregon State University
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

package 'yum-cron'

template node['yum-cron']['daily_conf'] do
  owner 'root'
  group 'root'
  mode 0640
  if node['platform_version'].to_i > 6
    variables(
      :commands => node['yum-cron']['daily']['commands'],
      :emitters => node['yum-cron']['daily']['emitters'],
      :email => node['yum-cron']['daily']['email'],
      :groups => node['yum-cron']['daily']['groups'],
      :base => node['yum-cron']['daily']['base']
    )
  end
  notifies :restart, 'service[yum-cron]', :delayed
end

if node['yum-cron']['hourly_conf']
  template node['yum-cron']['hourly_conf'] do
    owner 'root'
    group 'root'
    mode 0640
    variables(
      :commands => node['yum-cron']['hourly']['commands'],
      :emitters => node['yum-cron']['hourly']['emitters'],
      :email => node['yum-cron']['hourly']['email'],
      :groups => node['yum-cron']['hourly']['groups'],
      :base => node['yum-cron']['hourly']['base']
    )
    notifies :restart, 'service[yum-cron]', :delayed
  end
end

service 'yum-cron' do
  action [:start, :enable]
end

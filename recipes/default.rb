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

%w(daily hourly).each do |t|
  next unless node['yum-cron']["#{t}_conf"]
  template node['yum-cron']["#{t}_conf"] do
    owner 'root'
    group 'root'
    mode 0640
    if node['platform_version'].to_i > 6
      variables(
        commands: node['yum-cron'][t]['commands'],
        emitters: node['yum-cron'][t]['emitters'],
        email: node['yum-cron'][t]['email'],
        groups: node['yum-cron'][t]['groups'],
        base: node['yum-cron'][t]['base']
      )
    end
    notifies :restart, 'service[yum-cron]', :delayed
  end
end

service 'yum-cron' do
  action [:start, :enable]
end

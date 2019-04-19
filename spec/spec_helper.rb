require 'chefspec'
require 'chefspec/berkshelf'

ChefSpec::Coverage.start! { add_filter 'yum-cron' }

CENTOS_7_OPTS = {
  platform: 'centos',
  version: '7.4.1708',
  log_level: :fatal,
}.freeze

CENTOS_6_OPTS = {
  platform: 'centos',
  version: '6.9',
  log_level: :fatal,
}.freeze

name             'yum-cron'
issues_url       'https://github.com/osuosl-cookbooks/yum-cron/issues'
source_url       'https://github.com/osuosl-cookbooks/yum-cron'
maintainer       'Oregon State University'
maintainer_email 'chef@osuosl.org'
license          'Apache-2.0'
chef_version     '>= 12.18' if respond_to?(:chef_version)
description      'Installs/Configures yum-cron'
long_description 'Installs/Configures yum-cron'
version          '1.1.0'

supports         'centos', '~> 6.0'
supports         'centos', '~> 7.0'
supports         'centos', '~> 8.0'

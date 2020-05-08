require 'spec_helper'

describe 'yum-cron::default' do
  [CENTOS_8, CENTOS_7, CENTOS_6].each do |pltfrm|
    describe "on #{pltfrm[:platform]} #{pltfrm[:version]}" do
      cached(:chef_run) do
        ChefSpec::SoloRunner.new(pltfrm).converge(described_recipe)
      end

      case pltfrm
      when CENTOS_8
        it do
          expect(chef_run).to_not install_package('yum-cron')
        end
        it do
          expect(chef_run).to_not create_template('/etc/yum/yum-cron-hourly.conf')
        end
        it do
          expect(chef_run).to_not create_template('/etc/sysconfig/yum-cron')
        end
        it do
          expect(chef_run).to_not create_template('/etc/yum/yum-cron.conf')
        end
        it do
          expect(chef_run).to_not enable_service('yum-cron')
        end

      when CENTOS_7
        it do
          expect(chef_run).to install_package('yum-cron')
        end
        describe 'template /etc/yum/yum-cron.conf' do
          let(:file) { chef_run.template('/etc/yum/yum-cron.conf') }
          [
            /^update_cmd = default$/,
            /^update_messages = yes$/,
            /^download_updates = yes$/,
            /^apply_updates = yes$/,
            /^random_sleep = 360$/,
            /^system_name = None$/,
            /^emit_via = stdio$/,
            /^output_width = 80$/,
            /^email_from = root@localhost$/,
            /^email_to = root$/,
            /^email_host = localhost$/,
            /^group_list = None$/,
            /^group_package_types = mandatory, default$/,
            /^debuglevel = -2$/,
            /^skip_broken = False$/,
            /^mdpolicy = group:main$/,
            /^assumeyes = False$/,
          ].each do |regex|
            it do
              expect(chef_run).to render_file(file.name)
                .with_content(regex)
            end
          end
        end
        it do
          expect(chef_run).to create_template('/etc/yum/yum-cron.conf')
        end

        describe 'template /etc/yum/yum-cron-hourly.conf' do
          let(:file) { chef_run.template('/etc/yum/yum-cron-hourly.conf') }
          [
            /^update_cmd = default$/,
            /^update_messages = no$/,
            /^download_updates = no$/,
            /^apply_updates = no$/,
            /^random_sleep = 15$/,
            /^system_name = None$/,
            /^emit_via = stdio$/,
            /^output_width = 80$/,
            /^email_from = root@localhost$/,
            /^email_to = root/,
            /^email_host = localhost$/,
            /^group_list = None$/,
            /^group_package_types = mandatory, default$/,
            /^debuglevel = -2$/,
            /^skip_broken = False$/,
            /^mdpolicy = group:main$/,
            /^assumeyes = False$/,
          ].each do |regex|
            it do
              expect(chef_run).to render_file(file.name)
                .with_content(regex)
            end
          end
        end
        it do
          expect(chef_run).to create_template('/etc/yum/yum-cron-hourly.conf').with(
            owner: 'root',
            group: 'root',
            mode: '640'
          )
        end
        it do
          expect(chef_run).to_not create_template('/etc/sysconfig/yum-cron')
        end
        it do
          expect(chef_run).to enable_service('yum-cron')
        end

      when CENTOS_6
        it do
          expect(chef_run).to install_package('yum-cron')
        end
        describe 'template /etc/sysconfig/yum-cron' do
          let(:file) { chef_run.template('/etc/sysconfig/yum-cron') }
          [
            /^YUM_PARAMETER=\"\"$/,
            /^CHECK_ONLY=\"no\"$/,
            /^CHECK_FIRST=\"no\"$/,
            /^DOWNLOAD_ONLY=\"no\"$/,
            /^ERROR_LEVEL=\"0\"$/,
            /^DEBUG_LEVEL=\"0\"$/,
            /^RANDOMWAIT=\"60\"$/,
            /^MAILTO=\"root\"$/,
            /^SYSTEMNAME=\"\"$/,
            /^DAYS_OF_WEEK=\"0123456\"$/,
            /^CLEANDAY=\"0\"$/,
            /^SERVICE_WAITS=\"yes\"$/,
            /^SERVICE_WAIT_TIME=\"300\"$/,
          ].each do |regex|
            it do
              expect(chef_run).to render_file(file.name)
                .with_content(regex)
            end
          end
        end
        it do
          expect(chef_run).to create_template('/etc/sysconfig/yum-cron')
        end
        it do
          expect(chef_run).to_not create_template('/etc/yum/yum-cron.conf')
        end
        it do
          expect(chef_run)
            .to_not create_template('/etc/yum/yum-cron-hourly.conf')
        end
        it do
          expect(chef_run).to start_service('yum-cron')
        end
        it do
          expect(chef_run).to enable_service('yum-cron')
        end
      end
    end
  end
end

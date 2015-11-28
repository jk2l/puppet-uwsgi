require 'spec_helper'

describe 'uwsgi' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "uwsgi class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('uwsgi::params') }
          it { is_expected.to contain_class('uwsgi::install').that_comes_before('uwsgi::config') }
          it { is_expected.to contain_class('uwsgi::config') }
          it { is_expected.to contain_class('uwsgi::service').that_subscribes_to('uwsgi::config') }

          it { is_expected.to contain_service('uwsgi') }
          it { is_expected.to contain_package('uwsgi').with_ensure('present') }

          it { should contain_user('uwsgi') }
          it { should contain_file('/etc/uwsgi.ini') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'uwsgi class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('uwsgi') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end

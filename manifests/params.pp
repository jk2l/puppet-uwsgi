# == Class: uwsgi::params
# Default parameters for configuring and installing
# uwsgi
#
# === Authors:
# - Josh Smeaton <josh.smeaton@gmail.com>
#
class uwsgi::params {
    $package_name        = 'uwsgi'
    $package_ensure      = 'present'
    $package_provider    = 'pip'
    $service_name        = 'uwsgi'
    $service_ensure      = true
    $service_enable      = true
    $service_provider    = 'upstart'
    $manage_service_file = true
    $config_file         = '/etc/uwsgi.ini'
    $tyrant              = true
    $install_pip         = true
    $install_python_dev  = true
    $log_file            = '/var/log/uwsgi/uwsgi-emperor.log'
    $log_rotate          = 'no'
    $python_pip          = 'python-pip'
    $service_file_ensure = 'present'
    $user                = 'uwsgi'
    $group               = 'uwsgi'

    case $::osfamily {
        'Redhat', 'Amazon': {
            $app_directory = '/etc/uwsgi.d'
            $pidfile       = '/var/run/uwsgi/uwsgi.pid'
            $python_dev    = 'python-devel'
            $socket        = '/var/run/uwsgi/uwsgi.socket'
            $service_file  = '/etc/init.d/uwsgi'
            $service_file_template = 'uwsgi/uwsgi_service-redhat.erb'
            $service_mode  = '0555'
        }
        'Debian': {
            $app_directory = '/etc/uwsgi/apps-enabled'
            $pidfile       = '/run/uwsgi/uwsgi.pid'
            $python_dev    = 'python-dev'
            $socket        = '/run/uwsgi/uwsgi.socket'
            $service_file = '/etc/init/uwsgi.conf'
            $service_file_template = 'uwsgi/uwsgi_upstart.conf.erb'
            $service_mode = '0644'
        }
        default: {
          fail("${::operatingsystem} not supported")
        }
    }
}

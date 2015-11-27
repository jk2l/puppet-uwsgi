# == Class uwsgi::config
#
# This class is called from uwsgi for service config.
#
class uwsgi::config {

  file { $::uwsgi::config_file:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('uwsgi/uwsgi.ini.erb'),
  }


  file { $::uwsgi::service_file:
    ensure  => $::uwsgi::service_file_ensure,
    owner   => 'root',
    group   => 'root',
    mode    => $::uwsgi::service_mode,
    content => template($::uwsgi::service_file_template),
  }

  file { $::uwsgi::app_directory:
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }
}

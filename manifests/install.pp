# == Class uwsgi::install
#
# This class is called from uwsgi for install.
#
class uwsgi::install {

  if ! defined(Package[$uwsgi::python_dev]) and $uwsgi::install_python_dev {
    package { $uwsgi::python_dev:
      ensure => present,
      before => Package[$uwsgi::package_name],
    }
  }

  if ! defined(Package[$uwsgi::python_pip]) and $uwsgi::install_pip {
    package { $uwsgi::python_pip:
      ensure => present,
      before => Package[$uwsgi::package_name],
    }
  }

  user {$::uwsgi::user:
    ensure => present,
  }

  package { $uwsgi::package_name:
    ensure   => $uwsgi::package_ensure,
    provider => $uwsgi::package_provider,
  }

}

# == Define: uwsgi::app
#
# Responsible for creating uwsgi applications. You shouldn't need to use this
# type directly, as the main `uwsgi` class uses this type internally.
#
# === Parameters
#
# [*ensure*]
#    Ensure the config file exists. Default: 'present'
#
# [*template*]
#    The template used to construct the config file.
#    Default: 'uwsgi/uwsgi_app.ini.erb'
#
# [*uid*]
#    The user to run the application as. Required.
#    May be the user name, not just the id.
#
# [*gid*]
#    The group to run the application as. Required.
#    May be the group name, not just the id.
#
# [*application_options*]
#    Extra options to set in the application config file
#
# [*environment_variables*]
#    Extra environment variables to set in the application config file
#
# === Authors
# - Josh Smeaton <josh.smeaton@gmail.com>
# - Colin Wood <cwood06@gmail.com>
#
define uwsgi::app (
    $uid                   = $::uwsgi::user,
    $gid                   = $::uwsgi::group,
    $ensure                = 'present',
    $template              = 'uwsgi/uwsgi_app.ini.erb',
    $application_options   = undef,
    $environment_variables = undef,
    $forreadline = undef,
) {

  if is_string($forreadline) {
    validate_absolute_path($forreadline)
  }

  validate_string($uid)
  validate_string($gid)
  validete_string($template)
  if $application_options {
    validate_hash($application_options)
  }

  if $environment_variables {
    validate_hash($environment_variables)
  }

  include ::uwsgi

  file { "${::uwsgi::app_directory}/${title}.ini":
    ensure  => $ensure,
    owner   => $uid,
    group   => $gid,
    mode    => '0644',
    content => template($template),
    require => Class['uwsgi'],
  }
}

# Module only for physical machines that sets up lm_sensors
class lm_sensors (
  Boolean $service_enable                   = $::lm_sensors::params::service_enable,
  Enum['present','absent'] $package_ensure  = $::lm_sensors::params::package_ensure,
  Enum['running','stopped'] $service_ensure = $::lm_sensors::params::service_ensure,
  Stdlib::Absolutepath $config_file         = $::lm_sensors::params::config_file,
  Stdlib::Absolutepath $sensorsd_dir        = $::lm_sensors::params::sensorsd_dir,
  String $exec_command                      = $::lm_sensors::params::exec_command,
  String $package                           = $::lm_sensors::params::package,
) inherits ::lm_sensors::params {

  if $::virtual == 'physical' {
    include ::lm_sensors::install
    include ::lm_sensors::service
  }
}

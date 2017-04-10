# Sane defaults for lm_sensors
class lm_sensors::params {
  $package_ensure = 'present'
  $sensorsd_dir   = '/etc/sensors.d'
  $service_enable = true
  $service_ensure = 'running'

  case $::osfamily {
    'Debian': {
      $config_file  = '/etc/modules'
      $exec_command = '/usr/bin/yes "yes" | /usr/sbin/sensors-detect > /dev/null'
      $package      = 'lm-sensors'
    }
    'RedHat': {
      $config_file  = '/etc/sysconfig/lm_sensors'
      $exec_command = '/usr/sbin/sensors-detect < /dev/null'
      $package      = 'lm_sensors'
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }
}

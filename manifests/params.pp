# Module only for physical machines that sets up lm_sensors
class lm_sensors::params {
  $package_ensure = 'present'
  $service_ensure = 'running'
  $service_enable = true
  $sensorsd_dir   = '/etc/sensors.d'

  case $::osfamily {
    'RedHat': {
      $config_file  = '/etc/sysconfig/lm_sensors'
      $package      = 'lm_sensors'
      $exec_command = '/usr/sbin/sensors-detect < /dev/null'
    }
    'Debian': {
      $config_file  = '/etc/modules'
      $package      = 'lm-sensors'
      $exec_command = '/usr/bin/yes "yes" | /usr/sbin/sensors-detect > /dev/null'
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }
}

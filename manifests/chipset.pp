# Module only for physical machines that sets up lm_sensors
class lm_sensors::chipset (
  String $chipset,
  Array $chip_configs,
  Enum['file', 'absent'] $ensure,
) {

  # create sensors.d dir
  file {
    $::lm_sensors::sensorsd_dir:
      ensure  => directory,
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      require => Package['lm_sensors'];
    "chipset_${title}":
      ensure  => $ensure,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      require => File[$::lm_sensors::sensorsd_dir],
      notify  => Service['lm_sensors'],
      content => template(lm_sensors/chipset.conf);
    }
  }
}

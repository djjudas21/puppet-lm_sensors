class lm_sensors::chipset (
  Array $chip_configs,
  Enum['present', 'absent'] $ensure,
  String $title,
) {

  if $ensure == 'present' {
    $real_ensure = 'file'
  }

  # create sensors.d dir & chipset file
  file {
    $::lm_sensors::sensorsd_dir:
      ensure  => directory,
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      require => Package['lm_sensors'];
    "chipset_${title}":
      ensure  => $real_ensure,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      require => File[$::lm_sensors::sensorsd_dir],
      notify  => Service['lm_sensors'],
      content => template('lm_sensors/chipset.conf');
    }
  }
}

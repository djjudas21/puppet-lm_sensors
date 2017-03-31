# Type: lm_sensors::chipset
define lm_sensors::chipset (
  Array $chip_configs = [],
  Enum['present', 'absent'] $ensure = 'absent',
  String $chip = $title,
) {

  if $ensure == 'present' {
    $real_ensure = 'file'
  }
  else {
    $real_ensure = 'absent'
  }

  # create sensors.d dir & chipset file
  file {
    $::lm_sensors::sensorsd_dir:
      ensure  => directory,
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      require => Package['lm_sensors'];
    "${::lm_sensors::sensorsd_dir}/chip_${chip}.conf":
      ensure  => $real_ensure,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      require => File[$::lm_sensors::sensorsd_dir],
      notify  => Service['lm_sensors'],
      content => template('lm_sensors/chipset.conf');
  }
}

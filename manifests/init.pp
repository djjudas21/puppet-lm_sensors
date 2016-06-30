# Module only for physical machines that sets up lm_sensors
class lm_sensors {
  if $::virtual == 'physical' {
    # Path to config file
    $config = $::osfamily ? {
      'RedHat' => '/etc/sysconfig/lm_sensors',
      'Debian' => '/etc/modules',
    }

    $exec_command = $::osfamily ? {
      'RedHat' => '/usr/sbin/sensors-detect < /dev/null',
      'Debian' => '/usr/bin/yes "yes" | /usr/sbin/sensors-detect > /dev/null',
    }

    # Name of service/package
    $package = $::osfamily ? {
      'RedHat' => 'lm_sensors',
      'Debian' => 'lm-sensors',
    }

    # Install lm_sensors
    package { 'lm_sensors':
      ensure => installed,
      name   => $package,
      notify => Exec['sensors-detect'],
    }

    # Scan for hardware sensors
    exec { 'sensors-detect':
      command => $exec_command,
      unless  => "/bin/grep \"Generated by sensors-detect\" ${config}",
      notify  => Service['lm_sensors'],
      require => Package['lm_sensors'],
    }

    # Start lm_sensors service
    service { 'lm_sensors':
      ensure     => running,
      name       => $package,
      enable     => true,
      hasrestart => true,
      require    => [
        Package['lm_sensors'],
        Exec['sensors-detect'],
      ],
    }
  }
}

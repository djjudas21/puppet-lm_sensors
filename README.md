# lm_sensors

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)

## Overview

This Puppet module installs and configures lm_sensors on Linux

## Module Description

The module is very simple. It installs the lm_sensors package, runs the configuration
script to detect your system's sensors, and starts up the service so you can
interrogate it.

## Usage

To use it, just:
`class { '::lm_sensors': }`

To configure a chip:
`lm_sensors::chipset { 'mysqlbackup':
  ensure => present
  chipset => 'nct6776-isa-0290',
  chip_configs => ['ignore in1', 'label temp3 "SYS Temp"', 'compute temp3 @-20,@-20']
}`

## Reference

## Limitations

This module has no external dependencies on other modules. The code is simple and
should run on any Puppet since 0.2.x.

Since lm_sensors requires hardware sensors, this module will have no effect when
run on a virtual machine (although it is safe).

## Development

Feel free to fork and send pull requests, or just make feature requests in the
issue tracker. I can't guarantee having the time to look at anything.

The best way of contributing to this module is to improve support for different
Linux distros. Please let me know in an issue if you have tested successfully
on a platform that is not listed.

## Changelog

### `0.2.2`

Add basic tests and Travis CI config

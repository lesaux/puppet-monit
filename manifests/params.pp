class monit::params {
  case $::lsbdistcodename {
    'squeeze': {
    }
    'trusty': {
    }
    default: {
      fail("Module ${module_name} does not support ${::lsbdistcodename}")
    }
  }
}

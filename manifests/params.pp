class monit::params {

case $::osfamily {

  'redhat': {
    case $::operatingsystemmajrelease {
      '6': {
      }
      default: {
      fail("Module ${module_name} does not support ${::lsbdistcodename}")
      }     
    }
  }
    
  'debian': {
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

}

}

define monit::service() {

case $::osfamily {

  'debian': {
    file { "/etc/monit/conf.d/${name}":
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template("monit/common/etc/monit/conf.d/${name}"),
      notify  => Service['monit'],
      require => [ File['conf.d'],Package['monit'] ],
    }
  }

  'redhat': {
    file { "/etc/monit.d/${name}":
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template("monit/common/etc/monit/conf.d/${name}"),
      notify  => Service['monit'],
      require => [ File['conf.d'],Package['monit'] ],
    }

  }

}

}

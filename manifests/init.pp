class monit inherits monit::params {

case $::osfamily {
  'redhat': {

    include epel

    file { '/etc/monit.d':
      ensure  => directory,
      force   => true,
      purge   => true,
      recurse => true,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      alias   => 'conf.d',
      require => Package['monit'],
    }

    file { '/var/lib/monit':
      ensure  => directory,
      force   => true,
      #purge   => true,
      recurse => true,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      alias   => 'lib',
      require => Package['monit'],
    }

    file { '/etc/monit.conf':
      owner   => 'root',
      group   => 'root',
      mode    => '0600',
      alias   => 'monitrc',
      content => template("monit/${::osfamily}/${::operatingsystemmajrelease}/etc/monit.conf.erb"),
      notify  => Service['monit'],
      require => Package['monit'],
    }

    service { 'monit':
      ensure     => running,
      enable     => true,
      hasrestart => true,
      hasstatus  => false,
      require    => [
        File['monitrc'],
        File['lib'],
        Package['monit']
      ],
    }

  }

  'debian': {

    file { '/etc/default/monit':
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      alias   => 'monit',
      source  => "puppet:///modules/monit/${::lsbdistcodename}/etc/default/monit",
      notify  => Service['monit'],
      require => Package['monit'],
    }

    file { '/etc/monit/conf.d':
      ensure  => directory,
      force   => true,
      purge   => true,
      recurse => true,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      alias   => 'conf.d',
      require => Package['monit'],
    }

    file { '/etc/monit/monitrc':
      owner   => 'root',
      group   => 'root',
      mode    => '0600',
      alias   => 'monitrc',
      content => template("monit/${::lsbdistcodename}/etc/monit/monitrc.erb"),
      notify  => Service['monit'],
      require => Package['monit'],
    }
  
    service { 'monit':
      ensure     => running,
      enable     => true,
      hasrestart => true,
      hasstatus  => false,
      require    => [
        File['monit'],
        File['monitrc'],
        Package['monit']
      ],
    }

  }
  default: {
     # ...
  }
}

  package { 'monit':
    ensure => present,
  }

}

class jenkins_slave::headed (
  $slave_home = '/home/jenkins-slave',
  $master_url = undef,
  $jnlp_url = undef,
  $slave_secret = undef,
  $slave_user = 'jenkins-slave',
  $client_jar = 'slave.jar'
) {

  class { 'jenkins_slave::user':
    slave_home => $slave_home,
    slave_user => $slave_user,
    groups     => ['nopasswdlogin']
  }

  package { 'lightdm':
    ensure => installed
  }
  service { 'lightdm':
    ensure  => running,
    require => Package['lightdm']
  }

  file { '/usr/share/xsessions':
    ensure => directory
  }

  file { '/usr/share/xsessions/jenkins-slave.desktop':
    ensure  => file,
    source => 'puppet:///modules/jenkins_slave/jenkins-slave-session.desktop',
    notify  => Service['lightdm'],
    require => File['/usr/share/xsessions']
  }

  file { '/usr/bin/start-jenkins-slave.sh':
    ensure  => file,
    mode => 'a=rx,u+w',
    content  => template('jenkins_slave/start-jenkins-slave.sh.erb')
  }

  ini_setting { 'guest':
    setting => 'autologin-guest',
    value   => false,
  }
  ini_setting { 'user':
    setting => 'autologin-user',
    value   => $slave_user,
  }
  ini_setting { 'user-timeout':
    setting => 'autologin-user-timeout',
    value   => 0,
  }
  ini_setting { 'session':
    setting => 'autologin-session',
    value   => 'jenkins-slave',
  }
  ini_setting { 'user-session':
    setting => 'user-session',
    value   => 'jenkins-slave',
  }
  Ini_Setting['guest','user','user-timeout','session', 'user-session'] {
    ensure  => present,
    path    => '/etc/lightdm/lightdm.conf',
    section => 'SeatDefaults',
    require => Package['lightdm'],
    notify  => Service['lightdm']
  }

  class { 'jenkins_slave::slave_jar':
    slave_home => $slave_home,
    master_url => $master_url,
    slave_user => $slave_user,
    client_jar => $client_jar,
  }
}

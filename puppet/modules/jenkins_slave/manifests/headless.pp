class jenkins_slave::headless (
  $slave_home = '/home/jenkins-slave',
  $master_url = undef,
  $jnlp_url = undef,
  $slave_secret = undef,
  $slave_user = 'jenkins-slave',
  $client_jar = 'slave.jar',
) {
  package { 'daemon':
    ensure => present,
    before => Service['jenkins-slave'],
  }

  file { '/etc/init.d/jenkins-slave':
    ensure => 'file',
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
    source => "puppet:///modules/jenkins_slave/init-jenkins-slave.sh",
    notify => Service['jenkins-slave'],
  }

  file { "/etc/default/jenkins-slave":
    ensure  => 'file',
    mode    => '0600',
    owner   => 'root',
    group   => 'root',
    content => template("jenkins_slave/jenkins-slave-defaults.erb"),
    notify  => Service['jenkins-slave'],
  }

  service { 'jenkins-slave':
    ensure     => 'running',
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }

  class { 'jenkins_slave::user':
    slave_home => $slave_home,
    slave_user => $slave_user,
  }

  class { 'jenkins_slave::slave_jar':
    slave_home => $slave_home,
    master_url => $master_url,
    slave_user => $slave_user,
    client_jar => $client_jar,
    require => Class['jenkins_slave::user']
  }
  -> Service['jenkins-slave']
}

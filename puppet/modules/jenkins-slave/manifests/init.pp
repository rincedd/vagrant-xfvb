class jenkins-slave (
  $slave_home = '/home/jenkins-slave',
  $master_url = undef,
  $jnlp_url = undef,
  $slave_secret = undef,
  $slave_user = 'jenkins-slave',
  $ensure = 'running',
  $client_jar = 'slave.jar'
) {

  user { 'jenkins-slave_user':
    ensure     => present,
    name       => $slave_user,
    comment    => 'Jenkins Slave user',
    home       => $slave_home,
    managehome => true,
  }

  exec { 'get-slave-jar':
    command => "wget -O $slave_home/$client_jar $master_url/jnlpJars/$client_jar",
    path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    user    => $slave_user,
    creates => "${slave_home}/${client_jar}",
  }

  package { 'daemon':
    ensure => present,
    before => Service['jenkins-slave'],
  }

  file { '/etc/init.d/jenkins-slave':
    ensure => 'file',
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
    source => "puppet:///modules/jenkins-slave/init-jenkins-slave.sh",
    notify => Service['jenkins-slave'],
  }

  file { "/etc/default/jenkins-slave":
    ensure  => 'file',
    mode    => '0600',
    owner   => 'root',
    group   => 'root',
    content => template("jenkins-slave/jenkins-slave-defaults.erb"),
    notify  => Service['jenkins-slave'],
  }

  service { 'jenkins-slave':
    ensure     => $ensure,
    enable     => $enable,
    hasstatus  => true,
    hasrestart => true,
  }

  Exec['get-slave-jar']
  -> Service['jenkins-slave']

}

class jenkins_slave::slave_jar (
  $slave_home = '/home/jenkins-slave',
  $master_url = undef,
  $slave_user = 'jenkins-slave',
  $client_jar = 'slave.jar',
) {
  exec { 'get-slave-jar':
    command => "wget -O $slave_home/$client_jar $master_url/jnlpJars/$client_jar",
    path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    user    => $slave_user,
    creates => "${slave_home}/${client_jar}",
  }
}

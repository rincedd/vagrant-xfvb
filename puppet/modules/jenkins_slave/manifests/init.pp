class jenkins_slave (
  $slave_home = '/home/jenkins-slave',
  $master_url = undef,
  $jnlp_url = undef,
  $slave_secret = undef,
  $slave_user = 'jenkins-slave',
  $client_jar = 'slave.jar',
  $headless = true
) {
  if ($headless) {
    class { 'jenkins_slave::headless':
      slave_home   => $slave_home,
      master_url   => $master_url,
      jnlp_url     => $jnlp_url,
      slave_secret => $slave_secret,
      slave_user   => $slave_user,
      client_jar   => $client_jar
    }
  } else {
    class { 'jenkins_slave::headed':
      slave_home   => $slave_home,
      master_url   => $master_url,
      jnlp_url     => $jnlp_url,
      slave_secret => $slave_secret,
      slave_user   => $slave_user,
      client_jar   => $client_jar
    }
  }
}

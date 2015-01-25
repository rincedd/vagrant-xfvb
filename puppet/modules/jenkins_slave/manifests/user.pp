class jenkins_slave::user (
  $slave_home = '/home/jenkins-slave',
  $slave_user = 'jenkins-slave',
  $groups = []
) {
  user { 'jenkins-slave_user':
    ensure     => present,
    name       => $slave_user,
    comment    => 'Jenkins Slave user',
    home       => $slave_home,
    managehome => true,
    groups     => $groups
  }
}

package { 'git':
  ensure => installed,
}

class { 'nodejs':
  version => 'stable',
  make_install => false
}

package { 'grunt-cli':
  provider => 'npm',
  ensure => present,
  require => Class['nodejs']
}

package { 'bower':
  provider => 'npm',
  ensure => present,
  require => Class['nodejs']
}

class { 'java':
  distribution => 'jre'
}

class {'display':
  display => 99,
  width => 1280,
  height => 720,
  color => 16,
}

class { 'google_chrome':
  version => 'stable'
}

class { 'jenkins-slave':
  master_url => $::jenkins_master_url,
  jnlp_url => $::jenkins_slave_jnlp_url,
  slave_secret => $::jenkins_slave_secret
}

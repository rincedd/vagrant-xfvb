package { 'git':
  ensure => installed,
}

class { 'nodejs':
  version      => 'stable',
  make_install => false
}

package { 'grunt-cli':
  provider => 'npm',
  ensure   => present,
  require  => Class['nodejs']
}

package { 'bower':
  provider => 'npm',
  ensure   => present,
  require  => Class['nodejs']
}

class { 'java':
  distribution => 'jre'
}

class { 'google_chrome':
  version => 'stable'
}

class { 'jenkins_slave':
  master_url => $::jenkins_master_url,
  jnlp_url => $::jenkins_slave_jnlp_url,
  slave_secret => $::jenkins_slave_secret,
  slave_home => $::jenkins_slave_home,
  headless => false
}

class { 'ruby':; }
class { 'ruby::dev':; }

exec { 'install-composer':
  command => 'gem install compass compass-rgbapng',
  path => '/usr/bin:/usr/sbin:/sbin:/bin:/usr/local/bin',
  require => Class['ruby', 'ruby::dev']
}

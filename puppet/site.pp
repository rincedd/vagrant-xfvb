package { 'git':
  ensure => installed,
}

class { 'nodejs':; }

package { 'grunt-cli':
  provider => 'npm',
  ensure => installed
}

package { 'bower':
  provider => 'npm',
  ensure => installed
}

class { 'java':
  distribution => 'jre-headless'
}

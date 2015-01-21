package { 'git':
  ensure => installed,
}

#class { 'nodejs':; }
#
#package { 'grunt-cli':
#  provider => 'npm',
#  ensure => present
#}
#
#package { 'bower':
#  provider => 'npm',
#  ensure => present
#}

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

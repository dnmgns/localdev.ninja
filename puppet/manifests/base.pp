group {
    "puppet": ensure => "present",
}

class { "apache2":
    document_root => "/var/www/",
    log_directory => "_logs"
}

class { "php5":
    document_root => "/var/www/",
    xdebug_directory => "_xdebug"
}

class { "composer":
     target_dir   => '/usr/local/bin',
     user         => 'root',
     command_name => 'composer',
     auto_update  => true
}

class base {
    include mysql
    include apache2
    include php5
    include mail
    include rinetd
    include ntp
    include unzip
    include wget
    include composer
    include git
}

exec { "apt-update":
    command => "/usr/bin/apt-get update"
}

Exec["apt-update"] -> Package <| |>

include base

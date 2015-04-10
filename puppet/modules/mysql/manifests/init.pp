class mysql {

    package { "mysql-server": ensure => latest }
    package { "mysql-client": ensure => latest }

    file { "/usr/local/sbin/mysql-backup.sh":
        content => template("mysql/mysql-backup.erb"),
        mode => 755
    }

    file { "/etc/cron.d/mysql-backup":
        content => template("mysql/mysql-cron.erb"),
        mode => 644
    }

    file { "/etc/mysql/conf.d/virtualbox.cnf":
        content => template("mysql/virtualbox.erb"),
        mode => 644,
        require => Package['mysql-server']
    }

    file { "/vagrant/_mysql-backup":
        ensure => 'directory',
    }

    file { "/vagrant/_mysql-backup/tmp":
        ensure => 'directory',
    }

    service { "mysql":
        ensure => running,
        hasstatus => true,
        hasrestart => true,
        require => Package["mysql-server"],
    }

}

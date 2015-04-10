class mail {
    package { 'mailcatcher':
        ensure => 'installed',
        provider => 'gem',
        require => Package["libsqlite3-dev", "build-essential", "ruby-dev"],
    }

    package { 'ruby-dev':
        ensure => 'latest',
    }

    package { 'libsqlite3-dev':
        ensure => 'latest',
    }

    package { 'build-essential':
        ensure => 'latest',
    }

    file { "/etc/init.d/mailcatcher":
        content => template("mail/mailcatcher_init_d.erb"),
        mode => 0755,
        notify => Service['mailcatcher']
    }

    service { "mailcatcher":
        ensure => running,
        hasstatus => false,
        hasrestart => false,
        require => Package["mailcatcher"],
    }

    package { 'postfix':
        ensure => 'latest',
        before => [
            File['/etc/postfix/main.cf'],
        ]
    }

    file { "/etc/postfix/main.cf":
        content => template("mail/postfix_main_cf.erb"),
        notify => Service['postfix']
    }

    service { "postfix":
        ensure => running,
        hasstatus => true,
        hasrestart => true,
        require => Package["postfix"],
    }
}

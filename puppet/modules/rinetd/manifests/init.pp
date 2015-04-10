class rinetd {
    package { 'rinetd':
        ensure => 'latest',
    }

    file { "/etc/rinetd.conf":
        content => template("rinetd/rinetd_conf.erb"),
        mode => 0644,
        notify => Service['rinetd']
    }

    service { "rinetd":
        ensure => running,
        hasstatus => true,
        hasrestart => true,
        require => Package["rinetd"],
    }
}

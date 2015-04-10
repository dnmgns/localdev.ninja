class ntp {
    package { 'ntp':
        ensure => 'latest',
    }

    service { "ntp":
        ensure => running,
        hasstatus => true,
        hasrestart => true,
        require => Package["ntp"],
    }
}

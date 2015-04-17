class apache2($document_root, $log_directory) {

    package { "apache2":
        ensure => "latest",
        before => [
            File['/etc/apache2/sites-available/default'],
            File['/etc/apache2/envvars'],
            File['/etc/apache2/ports.conf'],
            File['/var/lock/apache2'],
            File['/etc/apache2/mods-enabled/rewrite.load'],
            File['/etc/apache2/mods-enabled/expires.load'],
            File['/etc/apache2/mods-enabled/headers.load'],
            File['/etc/apache2/mods-enabled/vhost_alias.load'],
            File['/etc/apache2/mods-enabled/ssl.load'],
            File['/etc/apache2/mods-enabled/ssl.conf'],
            File['/etc/ssl/private/localdev.ninja.key'],
            File['/etc/ssl/private/localdev.ninja.pem'],
            #File['/etc/ssl/private/localdevninja-intermediate.crt'],
        ]
    }

    file { "/etc/apache2/sites-available/default":
        content => template("apache2/vhost_default.erb"),
        notify => Service['apache2']
    }

    file { "/etc/apache2/envvars":
        content => template("apache2/envvars_default.erb"),
        notify => Service['apache2']
    }

    file { "/etc/apache2/ports.conf":
        content => template("apache2/ports.erb"),
        notify => Service['apache2']
    }

    file { "/vagrant/${log_directory}":
        ensure => 'directory',
        notify => Service['apache2']
    }

    file { "/var/lock/apache2":
        ensure => 'directory',
        owner => 'vagrant',
        notify => Service['apache2']
    }

    file { "/etc/apache2/mods-enabled/rewrite.load":
        ensure => link,
        target => "/etc/apache2/mods-available/rewrite.load",
        notify => Service['apache2']
    }

    file { "/etc/apache2/mods-enabled/expires.load":
        ensure => link,
        target => "/etc/apache2/mods-available/expires.load",
        notify => Service['apache2']
    }

    file { "/etc/apache2/mods-enabled/headers.load":
        ensure => link,
        target => "/etc/apache2/mods-available/headers.load",
        notify => Service['apache2']
    }

    file { "/etc/apache2/mods-enabled/vhost_alias.load":
        ensure => link,
        target => "/etc/apache2/mods-available/vhost_alias.load",
        notify => Service['apache2']
    }

    file { "/etc/apache2/mods-enabled/ssl.load":
        ensure => link,
        target => "/etc/apache2/mods-available/ssl.load",
        notify => Service['apache2']
    }

    file { "/etc/apache2/mods-enabled/ssl.conf":
        ensure => link,
        target => "/etc/apache2/mods-available/ssl.conf",
        notify => Service['apache2']
    }

    file { "/etc/ssl/private/localdev.ninja.key":
        content => template("apache2/localdev.ninja.key"),
        notify => Service['apache2']
    }

    file { "/etc/ssl/private/localdev.ninja.pem":
        content => template("apache2/localdev.ninja.pem"),
        notify => Service['apache2']
    }

    #file { "/etc/ssl/private/intermediate.crt":
    #    content => template("apache2/intermediate.crt"),
    #    notify => Service['apache2']
    #}

    service { "apache2":
        ensure => running,
        hasstatus => true,
        hasrestart => true,
        require => Package["apache2"],
    }
}

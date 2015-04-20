class php5($document_root, $xdebug_directory) {
    package {
        ["php5-cli", "php5-common", "php5-curl", "php5-gd", "php5-imagick", "php5-imap", "php5-mcrypt", "php5-mysql", "php-apc", "php5-xdebug", "libapache2-mod-php5", "php-pear"]:
            ensure => latest,
        before => [
            File['/etc/php5/conf.d/xdebug_config.ini'],
        ]
    }

    file { "/vagrant/$xdebug_directory":
        ensure => 'directory'
    }

    file { "/etc/php5/apache2/php.ini":
        content => template("php5/php_ini.erb"),
        notify => Service['apache2'],
        require => Package['libapache2-mod-php5']
    }

    file { "/etc/php5/conf.d/xdebug_config.ini":
        content => template("php5/xdebug_config.erb"),
        notify => Service['apache2'],
        require => Package['php5-xdebug']
    }

    file { "/etc/php5/cli/php.ini":
        content => template("php5/php_ini.erb"),
        require => Package['php5-cli']
    }

    file { "/etc/php5/conf.d/ioncube.ini":
        content => template("php5/ioncube.erb"),
        notify => Service['apache2'],
        require => Package['php5-common']
    }

    file { "/usr/lib/php5/ioncube_loader_lin_5.4.so":
        content => template("php5/ioncube_loader_lin_5.4.so"),
        notify => Service['apache2'],
        require => Package['php5-common']
    }
}

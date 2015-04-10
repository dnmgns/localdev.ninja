define drupal::mysqldbcreate( $user, $password , $dbname ) {
	exec { "create-drupal-db":
		    unless => "/usr/bin/mysql -u${user} -p${password} ${dbname}",
		    command => "/usr/bin/mysql -uroot -e \"create database ${dbname}; grant all on ${dbname}.* to ${user}@localhost identified by '${$password}';\"",
		    require => Service["mysql"],
	    }
}
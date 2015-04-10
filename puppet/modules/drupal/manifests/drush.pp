class drupal::drush {

	require composer

	exec { "install drush" :
	  command => "/usr/local/bin/composer global require drush/drush",
	  creates => "/usr/bin/vendor/drush/drush/drush",
	  environment => ["COMPOSER_HOME=/usr/bin"],
	}

	file { 'symlink drush':
		ensure  => link,
		path    => '/usr/bin/drush',
		target  => '/usr/bin/vendor/drush/drush/drush',
		require => Exec['install drush'],
		notify  => Exec['first drush run'],
	}

	# Needed to download a Pear library
	exec { 'first drush run':
		command     => '/usr/bin/drush cache-clear drush',
		refreshonly => true,
		require     => Exec['install drush'],
	}

}

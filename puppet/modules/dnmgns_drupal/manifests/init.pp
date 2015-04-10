class drupal {

	file { [ "/var/www/drupal/",
	         "/var/www/drupal/sites",
	         "/var/www/drupal/sites/all/",
	         "/var/www/drupal/sites/all/modules" ]:
	  ensure => directory,
	}

}

define module() {
  exec { "install-module-$name":
    cwd => "/var/www/drupal/sites/all/modules",
    command => "/usr/bin/drush dl $name",
    creates => "/var/www/drupal/sites/all/modules/$name",
  }
}

class drupal::modules {
  drupal::module { [ "admin_menu",
                     "cck",
                     "comment_notify",
                     "contact_forms",
                     "filefield",
                     "google_analytics",
                     "imagecache",
                     "nodewords",
                     "views",
                     "views_attach",
                     "views_bulk_operations",
                     "weblinks" ]: }
}
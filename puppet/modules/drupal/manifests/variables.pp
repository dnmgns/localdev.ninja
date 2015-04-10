class drupal::variables {

    #######################################################################
    # Binaries
    #######################################################################

    $binDrush = "/usr/bin/drush"
    $binMysql = "/usr/bin/mysql"
    $binWget = "/usr/bin/wget"
    $binUnzip = "/usr/bin/unzip"

    #######################################################################
    # Site database
    #######################################################################

    $dbName = "drupal_dev"
    $dbUsername = "drupal_dev"
    $dbPassword = "drupal_dev"
    $dbHost = "localhost"
    $dbPort = 3306

    #######################################################################
    # Site settings
    #######################################################################

    $siteTitle = "Dnmgns Website"
    $siteSlug = "dnmgnsdrupalwebsite"
    $siteLocale = "en-US"
    $siteAdminUsername = "admin"
    $siteAdminPassword = "password"

    #######################################################################
    # SMTP settings
    #######################################################################

    $smtpHost = "127.0.0.1"
    $smtpPort = 587
    $smtpUsername = "CHANGE ME"
    $smtpPassword = "CHANGE ME"
    $smtpFromEmail = "CHANGE ME"
    $smtpFromName = "CHANGE ME"
    $smtpDebug = 0

    #######################################################################
    # Locale settings
    #######################################################################

    $siteTimezone = "America/New_York"
    $siteCountry = "US"

    #######################################################################
    # Site paths
    #######################################################################

    $rootPath = "/var/www/drupaldev"
    $publicFolderName = "www"
    $docRootPath = "${rootPath}/${publicFolderName}"

}

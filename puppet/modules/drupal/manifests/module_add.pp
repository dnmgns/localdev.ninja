define drupal::module_add (
    $enableModules = [$title]
) {

    #######################################################################
    # Dependencies
    #######################################################################

    $moduleName = $title

    include drupal::drush
    include drupal::site

    Class['drupal::site'] -> Drupal::Module_add[$moduleName]

    $drupalRoot = "${drupal::variables::docRootPath}"

    #######################################################################
    # Add module
    #######################################################################

    exec { "download_drupal_module_${moduleName}":
        cwd => $drupal::variables::docRootPath,
        command => "${drupal::variables::binDrush} --root=${drupalRoot} dl ${moduleName} -y",
        timeout => 0,
        creates => "${drupal::variables::docRootPath}/sites/all/modules/${moduleName}"
    }

    exec { $enableModules:
        cwd => $drupal::variables::docRootPath,
        command => "${drupal::variables::binDrush} --root=${drupalRoot} en ${title} -y",
        timeout => 0,
        require => Exec["download_drupal_module_${moduleName}"],
        unless => "${drupal::variables::binDrush} --root=${drupalRoot} pm-list --no-core --status=enabled --type=module | grep ${title}"
    }

}

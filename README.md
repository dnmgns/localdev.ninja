## Prerequisites
1. [Vagrant 1.7.2](https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.2.dmg)
2. [Virtual Box 4.3.26](http://download.virtualbox.org/virtualbox/4.3.26)

## Environment information
If you provision the box it will contain Debian 7.8.0 and as little as possible.

From a web dev perspective you're probably interested in the fact that it contains the following software:
* php
* mysql
* apache
* mysql
* php
* composer
* postfix which relays all mail to mailcatcher

For now we just grab the latest versions, but in the future these will probably be set to specific versions.

It's also possible to create a drupal installation by uncommenting ```#include drupal``` in ```./puppet/manifests/base.pp```. Make sure that you set your drupal installation variables by editing ```./puppet/modules/drupal/manifests/variables.pp```.

## Installation
First, make sure that you've installed the above prerequisites.

Git clone to a folder of your choice. The environment (apache2) assumes that all your hosted projects are located at ```../``` from where you put the environment.
```~/dev``` is recommended.

Example:
```
mkdir ~/dev
git clone https://github.com/dnmgns/localdev.ninja.git ~/dev/
```

This Vagrant box uses NFS, if you run Linux or Mac OS X, and it must modify system files on the host. Therefore, at some point during the vagrant up sequence, you may be prompted for administrative privileges (via the typical sudo program). These privileges are used to modify /etc/exports as well as to start and stop the NFS server daemon.

If you don't want to type your password on every vagrant up, Vagrant uses thoughtfully crafted commands to make fine-grained sudoers modifications possible to avoid entering your password.

If you use another host OS, there's a couple example sudoers entries over at [http://docs.vagrantup.com/v2/synced-folders/nfs.html](http://docs.vagrantup.com/v2/synced-folders/nfs.html)

For OS X, sudoers should have this entry:
```
Cmnd_Alias VAGRANT_EXPORTS_ADD = /usr/bin/tee -a /etc/exports
Cmnd_Alias VAGRANT_NFSD = /sbin/nfsd restart
Cmnd_Alias VAGRANT_EXPORTS_REMOVE = /usr/bin/sed -E -e /*/ d -ibak /etc/exports
%admin ALL=(root) NOPASSWD: VAGRANT_EXPORTS_ADD, VAGRANT_NFSD, VAGRANT_EXPORTS_REMOVE
```

You can edit the sudoers file by running ```sudo visudo```in your terminal, or with your favorite text editor by editing ```/etc/sudoers```. Note that root permissions is needed.

## Quick start

Basically, getting the box up and running:
```
git clone https://github.com/dnmgns/localdev.ninja.git ~/dev/localdev.ninja/
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install caskroom/cask/brew-cask
brew cask install virtualbox
brew cask install vagrant
cd ~/dev/localdev.ninja/ && vagrant up
```

## Username and passwords
###Linux
username: root
password: vagrant

username: vagrant
password: root

###MySQL
username: root
<no password is set>

## HTTPS - Self-signed SSL certificate
Note: If you don't want to use HTTPS you may skip this step.

We're using a self-signed cert, you'll want to install the certificate into your certificate store. Otherwise you'll get a warning that the certificate is not trusted when browsing localninja.dev and using HTTPS.

On a Mac (that's what everyone uses, right?) you'll trust the certificate by launching your terminal and typing the below command. This will work given that you installed the localdev.ninja at the recommended path (~/dev/), otherwise you'll need to update this path in the command.

```cd ~/dev/localdev.ninja/puppet/modules/apache2/templates/ && sudo security add-trusted-cert -d -r trustRoot -k "/Library/Keychains/System.keychain" "./localdev.ninja.pem"```

Browsing your localdev.ninja site with HTTPS should now work fine without any 'certificate not trusted' warning.

## Usage
Launch the web dev environment with ```vagrant up``` from your shell.

Example:
```
cd ~/dev/localdev.ninja
vagrant up
```

Once up 'n running, you can access the site at ```http://project.localdev.ninja``` where project is the name of the directory inside ../project/www/ from where you launched your localdev.ninja environment.

Example for accessing project foobar which resides in ~/dev/foobar/:
```
localdev.ninja environment launched with 'vagrant up' command from ~/dev/localdev.ninja/
browsing to http://foobar.localdev.ninja now uses the document root ~/dev/foobar/www/
```

## Using localdev.ninja with a CMS (RewriteEngine on)

Some Content Management System (CMS) / Web application frameworks uses RewriteEngine, which is then set in the ```.htaccess``` file.

localdev.ninja uses apache2's VirtualDocumentRoot, in order for mod_rewrite to work with relative paths you'll the need to specify which folder the website is based in. This is done with RewriteBase, and you need to set it like this:
```
RewriteBase /
```

Example from Drupal CMS .htaccess:
```
  # Modify the RewriteBase if you are using Drupal in a subdirectory or in a
  # VirtualDocumentRoot and the rewrite rules are not working properly.
  # For example if your site is at http://example.com/drupal uncomment and
  # modify the following line:
  # RewriteBase /drupal
  #
  # If your site is running in a VirtualDocumentRoot at http://example.com/,
  # uncomment the following line:
  RewriteBase /
```

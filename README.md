One local webdev environment to rule them all.

## prerequisites
1. [Vagrant 1.7.2](https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.2.dmg)
2. [Virtual Box 4.3.26](http://download.virtualbox.org/virtualbox/4.3.26)

## Installation
Git clone to a folder of your choice. The environment (apache2) assumes that all your hosted projects are located at ```../``` from where you put the environment.
```~/dev``` is recommended.

Example:
```
mkdir ~/dev
git clone https://github.com/dnmgns/localdev.ninja.git ~/dev/
```

Launch the web dev environment with ```vagrant up``` from your shell.

Example:
```
cd ~/dev/localdev.ninja
vagrant up
```

This Vagrant box uses NFS, and it must modify system files on the host. Therefore, at some point during the vagrant up sequence, you may be prompted for administrative privileges (via the typical sudo program). These privileges are used to modify /etc/exports as well as to start and stop the NFS server daemon.

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

## Web dev environment information

If you provision the box it will contain as little as possible. From a web dev perspective you're probably interested in the fact that it contains the following software:
* php
* mysql
* apache
* composer
* postfix
* rinetd
* unzip
* wget

And in the future it will also be specific versions of these.

## Usage

Once up 'n running, you can access the site at ```http://project.localdev.ninja``` where project is the name of the folder inside ../ from where you launched your localdev.ninja environment.

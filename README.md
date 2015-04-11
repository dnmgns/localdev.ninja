One local webdev environment to rule them all.

## prerequisites
1. [Vagrant 1.7.2][1]
2. [Virtual Box 4.3.26][2]

## usage
Clone to a folder of your choice. The environment (apache2) assumes that all your hosted projects are located at ```../``` from where you put the environment.
```~/dev``` is recommended.

Launch the web dev environment with ```vagrant up``` from your shell.

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

[1]: https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.2.dmg
[2]: http://download.virtualbox.org/virtualbox/4.3.26
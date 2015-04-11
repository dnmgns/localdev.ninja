One local webdev environment to rule them all.

## prerequisites
1. [Vagrant 1.7.2](https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.2.dmg)
2. [Virtual Box 4.3.26](http://download.virtualbox.org/virtualbox/4.3.26)

## Installation and env info
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

## Usage

Once up 'n running, you can access your site at
```http://project.localdev.ninja```

Where project is the name of the folder inside ../ from where you launched your localdev.ninja environment.

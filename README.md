Vagrant Node.js + MongoDB + Cloud9 IDE Setup
============================================

Vagrant files to build Node.js box with MongoDB and Cloud9 IDE on Precise32 box based.

Installation
-------------

Install Vagrant from http://www.vagrantup.com/downloads.html

Type vagrant command to setup vagrant box

    $ vagrant up

> NOTE: Cloud9 IDE auto install script still on progress 

To access vagrant box type

    $ vagrant ssh
    
and if everything good there will be welcome screen like this one

    Welcome to Ubuntu 12.04 LTS (GNU/Linux 3.2.0-23-generic-pae i686)

    ========================
    System Info
    ========================
    Node v0.10.24
    
    MongoDB db version v2.0.4, pdfile version 4.5
    Wed Jan  1 04:55:33 git version: nogitversion
    
    MongoDB shell version: 2.0.4
    
    ========================
    
     * Documentation:  https://help.ubuntu.com/
    Welcome to your Vagrant-built virtual machine.
    Last login: Wed Jan  1 04:54:56 2014 from 10.0.2.2

    vagrant@precise32:~$
    
    
Usage 
-----

> TODO


Internal
--------

> NOTE: This processes automatically running by bootstrap.sh script so you don't need to do this manually.



Create service file for Node Forever
-----------------------------------

	$ chmod 755 /etc/init.d/nodejs


Run forever at startup 
----------------------
	
To enable at startup

    $ sudo update-rc.d nodejs defaults
	
To remove from startup

	$ sudo update-rc.d nodejs remove


Port forwading
--------------

Node.js app port forwading from port 80 to port 8085

Mongodb port forwading from port 27017 to port 27117


Setup MongoDB
-------------

edit /etc/mongodb.conf

	bind_ip = 0.0.0.0

restart mongodb

	sudo /etc/init.d/mongodb restart


Change Welcome Screen
---------------------

    $ sudo vim /etc/update-motd.d/00-header
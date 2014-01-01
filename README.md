Vagrant Node.js + MongoDB + Cloud9 IDE Setup
============================================

Vagrant files to build Node.js box with MongoDB and Cloud9 IDE on Precise32 box based.

Installation
-------------

Install Vagrant from http://www.vagrantup.com/downloads.html

Type vagrant command to setup vagrant box

    $ vagrant up

> NOTE: Cloud9 IDE auto install script still on progress 


Internal
--------

> NOTE: This processes automatically running by bootstrap.sh script so you don't need to do this manually.




Create service file for Node Forever
-----------------------------------

	$ chmod 755 /etc/init.d/nodejs


Run forever at startup 
----------------------
	
	to enable at startup

    $ update-rc.d nodejs defaults
	
	to remove from startup

	update-rc.d nodejs remove


Port forwading
--------------

Node.js app port forwading 80 -> 8085

Mongodb port forwading 27017 -> 27117


Setup MongoDB
-------------

edit /etc/mongodb.conf

	bind_ip = 0.0.0.0

restart mongodb

	sudo /etc/init.d/mongodb restart


Change Welcome Screen
---------------------

$ sudo vim /etc/update-motd.d/00-header
Vagrant Node.js + MongoDB + Cloud9 IDE Setup
============================================

Vagrant files to build Node.js box with MongoDB and Cloud9 IDE on Precise32 box based.

Installation
-------------

Install Vagrant from http://www.vagrantup.com/downloads.html

Type vagrant command to setup vagrant box

    $ vagrant up
    
> NOTE: This command will downloads all the necessary files to build vagrant nodejs box. It will take quite long time so it really depends on your computer speed and internet connectivity.

Usage
-----

####SSH

To access vagrant box via ssh from host computer

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
    

####MongoDB

Database access from host computer

    $ mongo -p 27117

####Web Application

To access web application from browser 

    http://localhost:8085

There some ways to develop nodejs application from host computer. 

**Cloud9 IDE**
     
Vagrant nodejs have web editor from [Cloud9][1]. To access it

    http://localhost:3131
    
![Cloud9 IDE Screenhost][2]

**Shared Folder**

The default shared folder host computer with vagrant nodejs box is

    ../sync/www
    
relative to vagrant nodejs directory. 

You can set the default folder to anything folder by setting vagrant file key 

    config.vm.synced_folder "../sync/www", "/home/vagrant/www", create: true


**Git**

> TODO

Internal
--------

> NOTE: This process automatically running by bootstrap.sh script so you don't need to do this manually.


Create service file for Node Forever
-----------------------------------

    $ chmod 755 /etc/init.d/nodejs

    $ chmod 755 /etc/init.d/cloud9

Run forever at startup 
----------------------
    
to enable at startup

    $ update-rc.d nodejs defaults
    
    $ update-rc.d cloud9 defaults
    
to remove from startup

    $ update-rc.d nodejs remove
    
    $ update-rc.d cloud9 remove

Port Forwading
--------------

Node.js app port forwading 80 to 8085

Mongodb port forwading 27017 to 27117

Cloud9 IDE forwarding default 3131 to 3131


Setup MongoDB
-------------

edit /etc/mongodb.conf

    bind_ip = 0.0.0.0

restart mongodb

    sudo /etc/init.d/mongodb restart


Change Welcome Screen
---------------------

    $ sudo vim /etc/update-motd.d/00-header


  [1]: https://github.com/ajaxorg/cloud9
  [2]: https://raw.github.com/junwatu/nodejs-vagrant/master/screenshot/cloud9.png
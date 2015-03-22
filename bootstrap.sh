#! /bin/bash

#*************************************************
# Change this to any version Node.js that you need
#*************************************************
NODE_VERSION=0.10.24

#*******************************************************************************
# Sample application to get started with Node.js and MongoDB
#*******************************************************************************
REPOSITORY_WWW="https://github.com/junwatu/nodejs-express-mongodb-start.git"
WEB_DIR="~/www"
HOME="/home/vagrant"

PROV_FILE=.vagrant_provision.lock

# Check provision file

if [ -f $PROV_FILE ];
then
	echo "no need provision"
	echo "exit..."
	exit 0
else
	echo "need provision"
	touch $PROV_FILE
fi

sudo apt-get update

# Install Git
sudo apt-get install -y git

# Install mongodb
sudo apt-get install -y mongodb

# Editor Vim
sudo apt-get install -y vim

# Build Latest Node.js
sudo apt-get install -y build-essential

if [ ! -f node-v$NODE_VERSION.tar.gz ]; then
	wget http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION.tar.gz
fi

tar zxvf node-v$NODE_VERSION.tar.gz -C .
cd node-v$NODE_VERSION
./configure --prefix=/usr
make && sudo make install

sudo npm install -g forever

# Get Repository
if [! -f $WEB_DIR ]; then
    rm -Rf $WEB_DIR
fi
git clone $REPOSITORY_WWW  $WEB_DIR

# Clean up
sudo rm -Rvf $HOME/.npm
sudo rm -Rvf $HOME/tmp

sudo chown -Rf vagrant.vagrant $WEB_DIR

cd $WEB_DIR
npm install

# Run forever at startup
cd /etc/init.d

if [ ! -f nodejs ]; then
    sudo wget https://raw.githubusercontent.com/junwatu/nodejs-vagrant/master/scripts/nodejs
    sudo chmod 755 nodejs
    sudo update-rc.d nodejs defaults
fi

#***************************
# Start services
#***************************

# Node.js
sudo /etc/init.d/nodejs restart

# Find and replace bind_ip to 0.0.0.0 on /etc/mongodb.conf
sudo sed -i 's/^.*bind_ip .*$/bind_ip\ =\ 0.0.0.0/' /etc/mongodb.conf

sudo service mongodb restart

#***************************
# Change Welcome Screen
#***************************

sudo sed -i '$a\
printf "\\n"\
printf "========================\\n"\
printf "System Info\\n"\
printf "========================\\n"\
printf "Node $(node --version)\\n\\n"\
printf "MongoDB $(mongod --version)\\n\\n"\
printf "$(mongo --version)\\n\\n"\
printf "========================\\n"'  /etc/update-motd.d/00-header


#***********************************
# Cloud9 IDE
# NOTE: 
# It install from repository 
# https://github.com/junwatu/cloud9
# 
#***********************************

git clone https://github.com/junwatu/cloud9
cd cloud9

# Depends on your system andn internet connection
# it takes time to build Cloud9 IDE deps

sudo npm install -g node-gyp

mkdir node_modules
cd node_modules
git clone https://github.com/junwatu/node-libxml.git node-libxml
cd libxml
./build.sh

cd $HOME/cloud9
npm install

npm install jsDAV

cd /etc/init.d

if [ ! -f cloud9 ]; then
    sudo wget https://raw.githubusercontent.com/junwatu/nodejs-vagrant/master/scripts/cloud9
    sudo chmod 755 cloud9
    sudo update-rc.d cloud9 defaults
fi


#***************************
# Start Cloud9 IDE
#***************************

sudo /etc/init.d/cloud9 start


#***************************
# Cleanup
#***************************
cd $HOME

sudo rm -Rvf node-v$NODE_VERSION
rm -f node-v$NODE_VERSION.tar.gz
sudo apt-get remove -y build-essential
sudo rm -Rvf $HOME/.npm
sudo rm -Rvf $HOME/tmp


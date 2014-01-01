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

cd $WEB_DIR

# Clean up
sudo rm -Rvf ../.npm
sudo rm -Rvf ../tmp

sudo chown -Rf vagrant.vagrant $WEB_DIR

npm install

# Run forever at startup
cd /etc/init.d

if [ ! -f nodejs ]; then
    sudo wget http://www.junwatu.com/files/vagrant/nodejs/scripts/nodejs
    sudo chmod 755 nodejs
    sudo update-rc.d nodejs defaults
fi

#***************************
# Cleanup
#***************************
cd ~

sudo rm -Rvf node-v$NODE_VERSION
rm -f node-v$NODE_VERSION.tar.gz
sudo apt-get remove -y build-essential

#***************************
# Start services
#***************************

# Node.js
sudo /etc/init.d/nodejs restart

# TODO
# uncomment bind_ip  on /etc/mongodb.conf
#
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

#!/usr/bin/env bash

# installation settings
PROJECT="nodeschool" # we would want a name passed to it via te first argument, $1
DB="nodeschool" # the name of postgreSQL DB we need to provision, maybe $2
NVM_DIR="/home/vagrant/.nvm"

# This file is executed by root user - sudo not needed
# But do not create any directory
# which vagrant user might need access to later in su mode
# use su - vagrant -c "" syntax
export DEBIAN_FRONTEND=noninteractive
echo "---------------------------------------------"
echo "Running vagrant provisioning"
echo "---------------------------------------------"

# install heroku toolbelt
echo "-------------- Installing heroku toolbelt -------------------------"
#wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh
# These shell script snippets are directly taken from heroku installation script
# We want to avoid the apt-get update
# add heroku repository to apt
echo "deb http://toolbelt.heroku.com/ubuntu ./" > /etc/apt/sources.list.d/heroku.list
# install heroku's release key for package verification
wget -O- https://toolbelt.heroku.com/apt/release.key 2>&1 | apt-key add -

echo "---------------------------------------------"
echo "------- Updating package dependencies -------"
echo "---------------------------------------------"
apt-get update -y # no need for sudo, and -y is needed to bypass the yes-no

echo "---------------------------------------------"
echo "-------- Installing packages ----------------"
echo "---------------------------------------------"
# install gcc and g++ and other build basics to ensure most software works
apt-get install -y --no-install-recommends heroku-toolbelt build-essential
# install the cli
su - vagrant -c "heroku --version > /dev/null 2>&1"

echo "---------------------------------------------"
echo "-------- Installing NVM & Node --------------"
echo "---------------------------------------------"

# install nvm
su - vagrant -c "wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.31.1/install.sh | bash"

# source bash
su - vagrant -c "source ~/.bashrc"

# install node
su - vagrant -c "nvm install v4.4.3"

echo "---------------------------------------------"
echo "--- Installing Workshopper modules ----------"
echo "---------------------------------------------"
## install nodeschool-workshopper modules

su - vagrant -c "npm i -g javascripting learnyounode git-it how-to-npm scope-chains-closures stream-adventure"
su - vagrant -c "npm i -g elementary-electron how-to-markdown functional-javascript-workshop expressworks"
su - vagrant -c "npm i -g promise-it-wont-hurt count-to-6"

echo "---------------------------------------------"
echo " Done! Run vagrant ssh to start working "
echo "---------------------------------------------"

#!/usr/bin/env bash

# installation settings
PROJECT="nodeschool" # we would want a name passed to it via te first argument, $1
DB="nodeschool" # the name of postgreSQL DB we need to provision, maybe $2

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
# wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh
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
su - vagrant -c "wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.31.1/install.sh | bash >/dev/null 2>&1"

# source bash and install node
su - vagrant <<NVM

source ~/.nvm/nvm.sh
echo 'Sourcing done'
nvm install 4.4.3 > /dev/null 2>&1
echo 'Installed node and npm successfully'

NVM

echo "---------------------------------------------"
echo "--- Installing Workshopper modules ----------"
echo "---------------------------------------------"

su - vagrant <<WORKSHOPPERS

source ~/.nvm/nvm.sh
echo "Installing javascripting ..."
npm i -g javascripting 2>&1
echo "Installing learnyounode ..."
npm i -g learnyounode 2>&1
echo "Installing git-it ..."
npm i -g git-it 2>&1
echo "Installing how-to-npm ..."
npm i -g how-to-npm 2>&1
echo "Installing scope-chains-closures ..."
npm i -g scope-chains-closures 2>&1
echo "Installing stream-adventure ..."
npm i -g stream-adventure 2>&1
echo "Installing elementary-electron ..."
npm i -g elementary-electron 2>&1
echo "Installing how-to-markdown ..."
npm i -g how-to-markdown 2>&1
echo "Installing functional-javascript-workshop ..."
npm i -g functional-javascript-workshop 2>&1
echo "Installing expressworks ..."
npm i -g expressworks 2>&1
echo "Installing promise-it-wont-hurt ..."
npm i -g promise-it-wont-hurt 2>&1
echo "Installing count-to-6 ..."
npm i -g count-to-6 2>&1

echo "All workshoppers installed."

WORKSHOPPERS

echo "---------------------------------------------"
echo " Done! Run vagrant ssh to start working "
echo "---------------------------------------------"

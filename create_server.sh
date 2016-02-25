#!/bin/bash

# first manually run the folowwing
# sudo adduser --group sudo kevin
# su kevin
read -p "Have you created user kevin? (Y-n)" -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

echo "Making sure everything is up to date"
sudo apt-get update
echo "installing vim"
sudo apt-get install vim

echo "Installing git"
sudo apt-get -y install git

#Install nodejs and dependencies
echo "Installing Curl and Nodejs"
sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev
curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get install -y build-essential

#Install rails and dependencies
echo "Installing Ruby"
cd
echo "First Clone - Rbenv"
git clone git://github.com/sstephenson/rbenv.git .rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.profile

echo "Second Clone - Plugins-Ruby"
git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
source ~/.profile

echo "Third Clone - Rehash"
git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash

echo "Install rbenv"
rbenv install 2.2.3
rbenv global 2.2.3

echo "Checking Ruby Version"
ruby -v

#Configure Git
echo "Configuring git"
git config --global color.ui true
# Add a bash variable to grab your name here
git config --global user.name "YOUR NAME"
# Add a bash variable to grab your password here
git config --global user.email "YOUR@EMAIL.com"
ssh-keygen -t rsa -C "YOUR@EMAIL.com"

#show the ssh key
cat ~/.ssh/id_rsa.pub
read -p "Please copy the above key to your github" -n 1 -r
ssh -T git@github.com

#Install rails
echo "Installing rails"
gem install rails -v 4.2.4
rbenv rehash
rails -v

echo "Installing Apache & dependencies w/ configuration"
sudo apt-get install apache2
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
gem install passenger
sudo apt-get install libcurl4-openssl-dev apache2-threaded-dev apache2-mpm-worker
passenger-install-apache2-module
sudo a2enconf httpd.conf
sudo echo "ServerName localhost" | sudo tee /etc/apache2/conf-available/servername.conf
sudo a2enconf servername
sudo service apache2 reload
#sudo vim /etc/apache2/conf-available/httpd.conf

#install postgresql
echo "Installing postgresql"
sudo apt-get update
sudo apt-get install postgresql postgresql-contrib libpq-dev
read -p "Now, look in the script and follow the directions at 75, then push enter" -n 1 -r
# change within /etc/postgresql/9.5/main/postgreql.conf
# use $ sudo vim
# listen_addresses = '*' # To which interface we should bind. '*'
#                        # makes your PostgreSQL visible to the Internet

echo "Starting PostgreSQL"
sudo /etc/init.d/postgresql start
sudo -u postgres createuser -s kevin

echo "Now type in: \password [your_username]"
echo "then type: [your_password] (then confirm)"
echo "then type: \q (to quit)"
sudo -u postgres psql
# #Then in postgres
# \password kevin
# --admin
# \q

echo "Congrats! Your server is up and running. Consult the bottom of the install script for configuration of of your rails app"

# ---THESE STEPS NEED TO BE MANUALLY COMPLETED---
# #create your rails server
# cd
# rails new myApp -d postgresql
# cd myApp
#
# #vi config/database.yml
# #Under the default section, find the line that says "pool: 5" and add the
# #following lines under it. It should look something like this (replace the
# #highlighted parts with your PostgreSQL user and password):
# # host: localhost
# # username: yourname
# # password: yourpassword
# #save and exit
# rake db:create
# #rails server #runs the dev environment
# rails server --binding=159.203.244.120
# #navigate to http://159.203.244.120:3000 to view

#Edit your default Webpage
sudo chown kevin /var/www/html
cd /var/www/html
rm -f index.html
touch index.html
echo "<!-- DOCTYPE html --><html><body>Hello from my running server!</body></html>" >> index.html
# -----------------
# The following are options to change within /etc/postgresql/9.5/main/postgreql.conf
# listen_addresses = '*' # To which interface we should bind. '*'
#                        # makes your PostgreSQL visible to the Internet
#
# max_connections = 200  # How many connections we should allow from
#                        # our app, workers, delayed_jobs etc. combined
# shared_buffers = 16GB  # How much memory our PostgreSQL can use for
#                        # buffers. Default value is insanely small.
#                        # If PostgreSQL is the only thing we run on
#                        # the machine, set it to 1/4 of available RAM
# work_mem = 10MB        # Increase the small value so the
#                        # sorts perform better.
# maintenance_work_mem = 128MB
#
# synchronous_commit = off # Speed up writes in exchange for possible
#                          # loss of data (be careful here!)
#
# wal_buffers = 16MB # Basically how much data we can loose. But
#                    # increasing makes things faster. Choose wisely.
#                    # Also applies to settings below.
# wal_writer_delay = 400ms
# checkpoint_segments = 32
# checkpoint_timeout = 900s
# checkpoint_completion_target = 0.9
#
# random_page_cost = 2.0 # Make planner use indices a bit more often
#                        # vs. sequential table scans.
#
# effective_cache_size = 32GB  # How much memory in total our
#                              # PostgreSQL can use. Twice of
#                              # shared_buffers seems good.

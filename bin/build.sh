#!/bin/bash

<<<<<<< HEAD
apk add --no-cache  gcc g++ libc-dev libxml2-dev linux-headers make postgresql-dev
apk add yarn graphviz chromium-chromedriver git openssh

=======
>>>>>>> a8bab9209d2832eeaa9cabf8e3767089735342bd

mkdir -p vendor/bundle
mkdir -p vendor/cache
mkdir -p config/certs
mkdir -p tmp/pids
<<<<<<< HEAD
mkdir -p node_modules
=======
>>>>>>> a8bab9209d2832eeaa9cabf8e3767089735342bd
touch config/certs/server.crt
touch config/certs/server.key

chown -R app:app ./*
chmod 600 config/certs/*
chmod 777 /usr/local/lib/ruby
<<<<<<< HEAD
chmod 777 /tmp
=======
>>>>>>> a8bab9209d2832eeaa9cabf8e3767089735342bd

# do on Dockerfile , it need root
#gem install bundler --version 2.5.23
echo 'gem: --no-document' > /usr/local/etc/gemrc
gem install bundler --version 2.5.23


cd /app

su -c 'bin/bundle config set path /app/vendor/bundle' app
# TODO productionの場合、
#bin/bundle install --without development test --jobs 4

echo ""
echo "bundle install"
su -c 'bin/bundle install --jobs 4' app

echo ""
echo "yarn install"
<<<<<<< HEAD
#yarn install
=======
>>>>>>> a8bab9209d2832eeaa9cabf8e3767089735342bd
su -c 'yarn install' app

echo ""
echo "webpack compile"
#su -c "bin/rails  webpacker:compile" app
su -c "bin/webpack -d & " app




echo ""
echo "assets:precompile"
su -c 'bin/rails assets:precompile' app

echo ""
echo "db:migrate"
su -c 'bin/rails db:migrate' app

echo ""
echo "db:seed"
su -c 'bin/rails db:seed' app



rm -f tmp/pids/server.pid


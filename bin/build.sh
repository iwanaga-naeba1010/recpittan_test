#!/bin/bash

apk add --no-cache  gcc g++ libc-dev libxml2-dev linux-headers make postgresql-dev
apk add yarn graphviz chromium-chromedriver git openssh

mkdir -p vendor/bundle
mkdir -p vendor/cache
mkdir -p config/certs
mkdir -p tmp/pids
mkdir -p node_modules
mkdir -p log

touch config/certs/server.crt
touch config/certs/server.key
touch log/build.log
touch log/webpack.log
touch .env
touch erd.pdf

chown -R app:app ./*
chmod 600 config/certs/*
chmod 777 /usr/local/lib/ruby
chmod 1777 /tmp

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
#yarn install
su -c 'yarn install' app

echo "set frontend key"
xapi=$( grep XAPIKEY  .env | cut -d '=' -f 2)
jsconstfile=app/javascript/utils/getapikey.ts
echo "export const xapikeyenv = '${xapi}'" > $jsconstfile
jsconstfile=reactSrc/utils/getapikey.ts
echo "export const xapikeyenv = '${xapi}'" > $jsconstfile



echo ""
echo "webpack compile"
#su -c "bin/rails  webpacker:compile" app

NODE_OPTIONS=--openssl-legacy-provider
export NODE_OPTIONS
# for Error: error:0308010C:digital envelope routines::unsupported
mkdir -p log
log=log/webpack.log
touch $log
su -c "bin/webpack -d > $log 2>&1  & " app
sleep 10


# webpackがcompileを完了しないと、aseets:precompileがerrorになるので、
# 暫定対応としてsleepする
# manifest.jsonが存在していればコンパイル済みとして処理する
# loop対応したい、、、
cnt=1
while true
do
    let cnt++
    if [ $cnt -ge 10 ]; then
        break
    fi
    sleep 2
    if [ -f public/packs/manifest.json ]; then
	break
    fi
done

echo ""
echo "assets:precompile"
su -c 'bin/rails assets:precompile' app
echo "done : assets:precompile"

echo ""
echo "db:migrate"
su -c 'bin/rails db:migrate' app
echo "done : db:migrate"

echo ""
echo "db:seed"
su -c 'bin/rails db:seed' app
echo "done : db:seed"


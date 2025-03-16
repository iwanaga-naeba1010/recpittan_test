#!/bin/bash


touch config/certs/server.crt
touch config/certs/server.key

rm -f tmp/pids/server.pid

mkdir -p log
log=log/webpack.log
bin/webpack -d > $log 2>&1  &

#bin/rails s -p 3000 -b '0.0.0.0'

if [ -s config/certs/server.crt ]; then
    echo "start with ssl"
    bundle exec pumactl start
else
    echo "start http only"
    bin/rails s -p 3000 -b '0.0.0.0'
fi



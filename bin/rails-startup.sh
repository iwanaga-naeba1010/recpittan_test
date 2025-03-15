#!/bin/bash


touch config/certs/server.crt
touch config/certs/server.key

rm -f tmp/pids/server.pid

bin/webpack -d &

#bin/rails s -p 3000 -b '0.0.0.0'

if [ -s config/certs/server.crt ]; then
    echo "start with ssl"
    bundle exec pumactl start
else
    echo "start http only"
    bin/rails s -p 3000 -b '0.0.0.0'
fi



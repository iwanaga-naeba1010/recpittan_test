#!/bin/bash

log=log/build.log
chown 1000:1000 $log
chmod 666 $log
echo "local=${LOCAL}" >> $log
if [ "${LOCAL}" != "true" ]; then
    /app/bin/awsgetkey_fromparamstore.sh >> $log 2>&1
    /app/bin/build.sh >> $log 2>&1
    su -c "/app/bin/rails-startup.sh >> $log 2>&1" app
else
    echo "nobuild" >> $log
    while true
    do
	sleep 10
    done
fi





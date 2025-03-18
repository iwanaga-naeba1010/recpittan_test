#!/usr/bin/bash

rm -fr erd.pdf

sudo chown -R 1000:1000 *

echo "" > log/build.log
echo "" > log/bullet.log
echo "" > log/development.log
echo "" > log/test.log
echo "" > log/webpack.log

echo "" > app/javascript/utils/getapikey.ts
echo "" > reactSrc/utils/getapikey.ts


rm -fr public/assets/*
rm -fr public/packs/*
rm -fr tmp/local_secret.txt
rm -fr tmp/miniprofiler/*
rm -fr coverage

cat /dev/null  > config/certs/server.crt
cat /dev/null > config/certs/server.key

log/.bash_history



echo "check AWS KEY"
grep -ir AKIASN *
grep -ir AKIASN .*

echo "check Slack webhook"
grep -ir hooks.slack *
grep -ir hooks.slack .*

echo "check app/javascript/channels"
ls -l app/javascript/channels

echo "check certs"
ls -l config/certs

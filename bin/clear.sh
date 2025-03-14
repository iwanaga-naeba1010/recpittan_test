#!/usr/bin/bash

rm -fr erd.pdf

sudo chown -R 1000:1000 *

echo "" > log/bullet.log
echo "" > log/development.log
echo "" > log/test.log
echo "" > log/build.log
rm -fr public/assets/*
rm -fr public/packs/*
rm -fr tmp/local_secret.txt
rm -fr tmp/miniprofiler/*
rm -fr coverage

cat /dev/null  > config/certs/server.crt
cat /dev/null > config/certs/server.key

log/.bash_history

ls -l config/certs

echo "check AWS KEY"
grep -ir AKIASN *
grep -ir AKIASN .*

echo "check Slack webhook"
grep -ir hooks.slack *
grep -ir hooks.slack .*

echo "app/javascript/channels"
ls -l app/javascript/channels

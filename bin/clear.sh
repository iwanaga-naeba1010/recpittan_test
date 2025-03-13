#!/usr/bin/bash

rm -fr erd.pdf


sudo chown -R 1000:1000 *

echo "" > log/bullet.log
echo "" > log/development.log
echo "" > log/test.log
rm -fr public/assets/*
rm -fr public/packs/*
rm -fr tmp/local_secret.txt
rm -fr tmp/miniprofiler/*
rm -fr coverage


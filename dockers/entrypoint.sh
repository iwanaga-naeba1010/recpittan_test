#!/bin/bash

/app/bin/bin/awsgetkey_fromparamstore.sh 2>&1
/app/bin/build.sh > log/build.log 2>&1
/app/bin/rails-startup.sh > log/build.log 2>&1



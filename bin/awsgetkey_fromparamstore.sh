#!/bin/bash

touch .env

# set aws credeintials
apk add aws-cli sudo

env | grep AWS_ACCESS > /dev/null
ret=$?
if [ $ret -eq 0 ]; then
    ak=$AWS_ACCESS_KEY_ID
    ac=$AWS_SECRET_ACCESS_KEY
else
    ak=$( grep AWS_ACCESS .env | cut -d '=' -f 2 | cut -d "'" -f 2)
    ac=$( grep AWS_SECRET .env | cut -d '=' -f 2 | cut -d "'" -f 2)
fi


cd
aws configure set aws_access_key_id $ak
aws configure set aws_secret_access_key $ac
aws configure set region ap-northeast-1
aws configure set output text

cd /app
# 証明書を保存するディレクトリを作成※ここはアプリに合わせて変更してください
CERT_DIR="config/certs"
mkdir -p "$CERT_DIR"

sudo rm -fr ${CERT_DIR}/*

echo "get crt"
aws ssm get-parameter --with-decryption --query "Parameter.Value" --output text --name "/rails_ssl/server_certs" > "$CERT_DIR/server.crt"

echo "get key"
aws ssm get-parameter --with-decryption --query "Parameter.Value" --output text --name "/rails_ssl/server_private" > "$CERT_DIR/server.key"

# 証明書の権限設定
chmod 600 "$CERT_DIR/server.crt"
chmod 600 "$CERT_DIR/server.key"

echo "SSL certificate setup completed successfully."

if [ -f .env ]; then
    eval "$(cat .env <(echo) <(declare -x))"
fi

echo $BRANCH
env | grep MAIL_SENDER_FROM > /dev/null
ret=$?
if [ $ret -ne 0 ]; then
    echo "get env"
    envs=$( aws ssm get-parameter --with-decryption --query "Parameter.Value" --output text --name "/env/${BRANCH}" )
    echo "$envs" >> .env
fi

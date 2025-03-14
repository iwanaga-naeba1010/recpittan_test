#!/bin/bash
set -e  # エラーが発生した場合にスクリプトを即終了

# 証明書を保存するディレクトリを作成※ここはアプリに合わせて変更してください
CERT_DIR="config/certs"
mkdir -p "$CERT_DIR"

sudo rm -fr ${CERT_DIR}/*

echo "Fetching SSL certificate from AWS SSM Parameter Store..."
aws ssm get-parameter --with-decryption --query "Parameter.Value" --output text --name "/rails_ssl/server_certs" > "$CERT_DIR/server.crt"

echo "Fetching SSL private key from AWS SSM Parameter Store..."
aws ssm get-parameter --with-decryption --query "Parameter.Value" --output text --name "/rails_ssl/server_private" > "$CERT_DIR/server.key"

# 証明書の権限設定
chmod 600 "$CERT_DIR/server.crt"
chmod 600 "$CERT_DIR/server.key"
sudo chown root:root "$CERT_DIR/server.crt"
sudo chown root:root "$CERT_DIR/server.key"

echo "SSL certificate setup completed successfully."

# get SLACK_WEBHOOK
slackwebhook=$( aws ssm get-parameter --with-decryption --query "Parameter.Value" --output text --name "SLACK_WEBHOOK" )
echo "SLACK_WEBHOOK=${slackwebhook}" >> .env


### 概要

マッチングシステムです

## 環境

- Ruby 3.3.6
- Rails 7.1.x
- PostgreSQL 12.5

## dockerのセットアップ

```
# 最初のセットアップ
docker-compose build

docker-compose up -d

# プロセス一覧
docker ps

# d up -d後のinstall系コマンド。コンテナを新規に立ち上げずに実行できるので早い
docker-compose exec web bundle install
docker-compose exec web yarn install

# pryなどを実行する方法
docker attach matching_system-web-1

# rspecの実行
docker-compose exec web bundle exec rspec

# もしtestDBがない場合は
docker-compose exec web bin/rails db:create RAILS_ENV=test
docker-compose exec web bin/rails db:migrate RAILS_ENV=test

# rubocopの実行
docker-compose exec web bundle exec rubocop

# brakemanの実行
docker-compose exec web bundle exec brakeman

# best practicesの実行
docker-compose exec web bundle exec rails_best_practices -e node_modules

# TypeScript/JavaScriptのlint実行
docker-compose exec web yarn lint

# TypeScript/JavaScriptのlint fix実行
docker-compose exec web yarn lint:fix
```

# dip

### 概要
マッチングシステムです

## 環境
- Ruby 3.0.3
- Rails 7.0.x
- PostgreSQL 12.5

## dockerのセットアップ
```
# 最初のセットアップ
docker-compose build

docker-compose up -d

# プロセス一覧
docker ps

# pryなどを実行する方法
docker attach matching_system_web_1

# rspecの実行
docker-compose run --rm web bundle exec rspec

# もしtestDBがない場合は
docker-compose run --rm web bin/rails db:create RAILS_ENV=test
docker-compose run --rm web bin/rails db:migrate RAILS_ENV=test

# rubocopの実行
docker-compose run --rm web bundle exec rubocop

# brakemanの実行
docker-compose run --rm web bundle exec brakeman

# best practicesの実行
docker-compose run --rm web bundle exec rails_best_practices -e node_modules

# ts/jsのlint実行
docker-compose run web yarn lint:fix
```

### gitのブランチの命名規則
```
issue-{githubのissue番号}で作業ごとにブランチを作成してもらいます。
例えば、issue番号が10であれば、指定のブランチから新しくissue-10を作成して作業を行ってください。

通暁「指定のブランチ」とはdevelopですが、featureブランチという
機能や新規リリースのためのブランチの場合もあるので、issueに記載がない場合は遠慮せずに効いてください。
githubのissue番号を
```

### 開発時間について
開発にかける時間はストーリーポイントとして管理しており、
Githubのissueの先頭にPMがポイントを記載しておきます。

ポイントには開発時間とコードレビューの時間も含まれますので、
8割程度の時間で開発を終える、ぐらいの計算でお願いします。

PT  | 工数
--- | ---
1pt | 半日
3pt | 1日
5pt | 2~3日
8pt | 4~5日
13pt | 7~9日

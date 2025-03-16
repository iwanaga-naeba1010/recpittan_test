#!/bin/bash

docker compose up -d --no-recreate  chrome
docker compose up -d --no-recreate  db


docker compose exec  web apk add chromium-chromedriver

echo "db create"
docker compose exec -e RAILS_ENV=test web bundle exec rails db:create

sleep 1
echo "db migrate"
docker compose exec -e RAILS_ENV=test web bundle exec rails db:migrate


sleep 1
echo "exec rspec"
docker compose exec -e RAILS_ENV=test web bundle exec rspec
#RAILS_ENV=test bundle exec rspec


#docker compose exec -e RAILS_ENV=test web bundle exec rspec

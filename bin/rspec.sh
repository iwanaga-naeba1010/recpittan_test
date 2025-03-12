#!/bin/bash

apk add chromium-chromedriver

RAILS_ENV=test bundle exec rspec


#docker compose exec -e RAILS_ENV=test web bundle exec rspec

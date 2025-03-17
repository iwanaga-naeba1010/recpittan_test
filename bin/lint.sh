#!/bin/bash

bin/bundle exec rubocop
bin/bundle exec brakeman
bin/bundle exec rails_best_practices -e node_modules
yarn lint


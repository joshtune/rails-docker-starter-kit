#!/bin/bash

echo "----------------------------------------------------"
echo " 1/3: Create new rails app"
echo "----------------------------------------------------"

docker-compose build
docker-compose run --rm app rails new . -d postgresql -f --skip-javascript	--skip-turbolinks --skip-system-test --api

echo "----------------------------------------------------"
echo " 2/3: Add defaults"
echo "----------------------------------------------------"

cp -rf docker/database.yml config
echo '.idea' >> .gitignore

echo "----------------------------------------------------"
echo " 3/3: Initialize App"
echo "----------------------------------------------------"

docker-compose build
docker-compose run --rm app rails db:reset
docker-compose run --rm app rails db:migrate
docker-compose run --rm app rails db:reset RAILS_ENV=test
docker-compose run --rm app rails db:migrate RAILS_ENV=test
docker-compose up -d

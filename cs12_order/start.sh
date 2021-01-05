#!/usr/bin/env bash

#if alredy running to stop containers
docker-compose down

#building the container
docker-compose up --build -d

echo "===== Installing Project Dependencies ====="
docker-compose run composer install --prefer-source --ignore-platform-reqs --no-interaction --no-progress --quiet

docker exec orderapi_php bash -c 'chmod 777 -R /var/www/html && php artisan optimize:clear'

docker exec orderapi_php php artisan migrate

docker exec orderapi_php php ./vendor/phpunit/phpunit/phpunit
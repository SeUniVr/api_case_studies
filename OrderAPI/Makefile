.PHONY: build build-source start start-dev stop refresh refresh-app refresh-db clean get-swagger-spec
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# All the commands require Docker to run without root  #
# privileges. Docker compose is also required.		   #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

########################################################
# The following command are used to build the containers
# and the app before the first execution.

build:
	@echo Building the containers..
	docker-compose build

build-source:
	@echo No source to build.

########################################################
# The following command are used to start or stop the
# containers when needed. These actions preserve the
# current state of the application 

start:
	@echo Running the system
	docker-compose up -d --no-recreate

start-dev:
	@echo Running with attached output
	docker-compose up --no-recreate

stop:
	@echo Stopping the containers..
	docker-compose stop

########################################################
# The following command are used to refresh some 
# containers. Their purpose is to restore the initial
# condition of parts of the application that could be
# broken.

refresh:
	@echo Rebuilding all the containers..
	make refresh-app
	make refresh-db

refresh-app:
	@echo Restoring the app to its original state..
	docker-compose stop  php
	docker-compose rm -f php
	docker-compose up -d php

refresh-db:
	@echo Restoring the database to its original state..
	docker-compose exec mysql bash -c 'mysql -u root -ppass@12345 < /docker-entrypoint-initdb.d/dump.sql'

########################################################
# The following command is used to clean up all the 
# application environment stopping and deleting all
# the related containers.

clean:
	@echo Cleaning up the application and removing the containers..
	docker-compose down --remove-orphans --volumes --rmi local

########################################################
# The following command is used to get the swagger 
# specification of the API. The retrieved file is stored
# in the current directory.

get-swagger-spec:
	@echo Getting swagger speciication..
	curl http://localhost:8080/swagger/swagger.json > ./swagger-specification.json
	@echo Done.
	cat ./swagger-specification.json

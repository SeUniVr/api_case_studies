.PHONY: build build-source start start-dev stop refresh refresh-app refresh-db clean get-swagger-spec
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# All the commands require Docker to run without root  #
# privileges. Docker compose is also required.		   #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

########################################################
# The following command are used to build the containers
# and the app before the first execution.

build:
	make clean

	@echo Building the containers..
	cd ./docker; docker-compose build
	docker run -v "`pwd`:/app" composer install
	#docker-compose up -d; \
	#echo Waiting for the database to start.. ; \
	#sleep 60; \
	#docker-compose exec php php artisan key:generate; \
	#docker-compose exec php php artisan jwt:secret; \
	#docker-compose exec php php artisan migrate; \
	#docker-compose stop;\
	# Seeds the database with DummyDataSeeder \
	#docker-compose exec php php artisan db:seed; \
	#docker-compose stop;

build-source:
	@echo No source to build.

########################################################
# The following command are used to start or stop the
# containers when needed. These actions preserve the
# current state of the application 

start:
	@echo Running the system
	cd ./docker; \
	docker-compose up -d --no-recreate; \
	docker-compose exec -d php php artisan serve --host=0.0.0.0;

start-dev:
	@echo Running with attached output
	cd ./docker; \
	docker-compose up -d --no-recreate; \
	docker-compose exec php php artisan serve --host=0.0.0.0;

stop:
	@echo Stopping the containers..
	cd ./docker; \
	docker-compose stop;

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
	cd ./docker; \
	docker-compose stop php; \
	docker-compose rm -f php; \
	docker-compose build php; \
	docker-compose up;

refresh-db:
	@echo Restoring the database to its original state..
	cd ./docker; \
	docker-compose exec mysql bash -c 'mysql -u root -proot < /docker-entrypoint-initdb.d/refresh_data.sql'

########################################################
# The following command is used to clean up all the 
# application environment stopping and deleting all
# the related containers.

clean:
	@echo Cleaning up the application and removing the containers..
	cd ./docker; \
	docker-compose down --remove-orphans --volumes --rmi local

########################################################
# The following command is used to get the swagger 
# specification of the API. The retrieved file is stored
# in the current directory.

get-swagger-spec:
	@echo Getting swagger speciication..
	@echo speciication found in `pwd`
	cat ./swagger.json

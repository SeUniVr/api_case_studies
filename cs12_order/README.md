#  Rest API for OrderAPI
API to Create, Fetch and Take orders.

## Docker, language, Framework, Database and server requirement

- [Docker](https://www.docker.com/) as the container service to isolate the environment.
- [Php](https://php.net/) to develop backend support.
- [Laravel](https://laravel.com) as the server framework / controller layer
- [MySQL](https://mysql.com/) as the database layer
- [NGINX](https://docs.nginx.com/nginx/admin-guide/content-cache/content-caching/) as a proxy / content-caching layer

## Installation steps to run the APP

1.  Clone the repo.
2. `src` folder contains the complete application code.
3.  As we have used the Google distance matrix api to calculate distance from the Co-ordinates, you need API key for the same. 
    Go to https://cloud.google.com/maps-platform/routes/ after login create new project and get the API key. 
    update 'GOOGLE_API_KEY' in environment file located in ./src/.env file
4.  Within the root folder you will find "start.sh" file. Run `./start.sh` to build docker containers, executing migration and PHPunit Unit & Feature test cases
5.  After starting container following will be executed automatically:
  - Composer will install all dependencies required to run the code.
  - Config and Application Cache will be cleared.
	- Table migrations using artisan migrate command.
	- Unit and Feature Integration test cases execution.

## For Migrating tables and Data Seeding

1. For running migrations manually `docker exec orderapi_php php artisan migrate`

## For manually running the docker and test Cases

1. You can run `docker-compose up` from terminal
2. Server is accessible at `http://localhost:8080`
3. To run the Feature test cases only:  `docker exec orderapi_php php ./vendor/phpunit/phpunit/phpunit ./tests/Feature`
4. To run the Unit test cases only:  `docker exec orderapi_php php ./vendor/phpunit/phpunit/phpunit ./tests/Unit`
5. Run both Feature Integration & Unit test case suite: `docker exec orderapi_php php ./vendor/phpunit/phpunit/phpunit`

## Swagger integration

1. Open URL for API demo `http://localhost:8080/api-documentation`
2. Here you can perform all API operations like GET, UPDATE, POST

## Code Structure
src folder contain application code.

**./tests**

- this folder contains both Feature and Unit test cases files.

**./app**

- Folder contains all the framework configuration file, controllers and models
- Migration files are present inside the database/migrations/ folder
	- To run manually migrations use this command `docker exec orderapi_php php artisan migrate`
- `OrderController` contains all the api's methods :
    1. localhost:8080/orders?page=1&limit=4 - GET url to fetch orders with page and limit
    2. localhost:8080/orders - POST method to insert new order with origin and distination
    3. localhost:8080/orders - PATCH method to update status for taken. (handled the concurrent request for taking the order. If order already taken then other request will get response status 409)
- `DistanceService` contains the logic to calculate distance from Co-ordinates.

**.env**

- env file contain all project configuration, you can configure database, session and custom configuration. We have set the GOOGLE_API_URL, GOOGLE_API_KEY and GOOGLE_API_UNIT in the env file so that it is configurable.

## API Reference Documentation
-  Find below API documentation for the help.
- `localhost:8080/orders?page=:page&limit=:limit` :

    GET Method - to fetch orders with page number and limit
    1. Header :
        - GET /orders?page=2&limit=3
        - Host: localhost:8080
        - Content-Type: application/json

    2. Responses :

    ```
            - Response
            [
              {
                "id": 4,
                "distance": 854523,
                "status": "TAKEN"
              },
              {
                "id": 5,
                "distance": 147959,
                "status": "UNASSIGNED"
              },
              {
                "id": 6,
                "distance": 19285,
                "status": "TAKEN"
              }
            ]
    ```

        Code                    Description
        - 200                   Successful Operation
        - 400                   Request Denied
        - 406                   Invalid Request Parameter

- `localhost:8080/orders` :

    POST Method - to create new order with origin and distination
    1. Header :
        - POST /orders
        - Host: localhost:8080
        - Content-Type: application/json

    2. Post-Data :
    ```
         {
            "origin": ["-33.865143","151.209900"],
            "destination": ["-37.663712","144.844788"]
         }
    ```

    3. Responses :
    ```
            - Response
            {
              "id": 1,
              "distance": 854523,
              "status": "UNASSIGNED"
            }
    ```

        Code                    Description
        - 200                   Successful Operation
        - 400                   Request Denied
        - 406                   Invalid Input

- `localhost:8080/orders/:id` :

    PATCH method to update status for orders already taken. (Handled simultaneous update request from multiple users at the same time with response status 409)
    1. Header :
        - PATCH /orders/3
        - Host: localhost:8080
        - Content-Type: application/json

    2. Post-Data :
    ```
         {
            "status" : "TAKEN"
         }
    ```

    3. Responses :
    ```
            - Response
            {
              "status": "SUCCESS"
            }
    ```
    or
    ```
            - Response
            {
              "status": "ORDER_ALREADY_TAKEN"
            }
    ```

        Code                    Description
        - 200                   successful operation
        - 400                   Invalid Request Parameter
        - 404                   Invalid Order Id
        - 409                   Order already taken

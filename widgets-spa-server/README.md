# Widgets Spa Server Demo

This is a microservice app demo project implemented using Golang programming language, MySQL database server and Swagger for API documentation. It creates two containers: one for the app and another for the database.

### Dependencies

- The main dependency for this project is the use of Docker platform. You can find information about how to setup Docker in your machine in order to run this project in the following site: https://docs.docker.com
- It was created a script using Make for building and executing this application. However, it is not required to use the script for running this application as it is composed of a bunch of docker commands. You can just copy and paste each command in the same order from makefile to your terminal. Information about Make can be found in the following link: https://www.gnu.org/software/make

## APIs

The APIs require a token for authentication. It is hard coded on code for testing purpose. The token is `access_token_secret` and it must be passed in the header of the http request as following: `"Authorization: access_token_secret"` (see example below). Besides, the APIs return and expect to receive JSON-encoded data.

### Description

- GET `/users` for geting a list of users
- GET `/users/:id` for getting a specific user
- GET `/widgets` for getting a list of widgets
- GET `/widgets/:id` for getting a specific widget
- POST `/widgets` for creating a new widget
- PUT `/widgets/:id` for updating an existing widget

## How to build and run this project

### Running the first time

1. Clone this repo on a local machine.

```
git clone https://github.com/emrachid/widgets-spa-server.git
```

2. Execute the Make command below to create and instanciate a database for the application. The database schema and data will be imported from `dump.sql` file upon creation. This file can be updated to include new data executing `make dump-db`. This script connect the database running and update `dump.sql` file so that the next database creation will include new data.

```
make create-db
```

3. The database server will take sometime to be available for establishing new connections. For checking if database is up and running, execute the following command until `"healthy"` is returned. If `"unhealthy"` is displayed, something wrong might be happened during the initialization of MySQL server and the container instance is down. In this case, you will need to figure out the problem. Check if there is another application using the same port `3306`.

```
make status-db
```

4. Execute the following command to initiate the application and connect it to the database server.

```
make run-app
```

### Start and stop

Once database is created for the first time, you can just start and stop its container for running the app again. The same procedure can be followed for the app container.

1. Start database

```
make start-db
```

2. Start app

```
make start-app
```

3. Stop app

```
make stop-app
```

4. Stop database

```
make stop-db
```

### How to send requests to the app

You can use any web tool like [Postman](https://www.getpostman.com) for sending http request for this application. I have used `curl` for this purpose. See the list of requests below:

  - Get a list of users:
```
curl -H "Authorization: access_token_secret" 127.0.0.1:8081/users
```

  - Get a specific user:
```
curl -H "Authorization: access_token_secret" 127.0.0.1:8081/users/1
```

  - Get a list of widgets:
```
curl -H "Authorization: access_token_secret" 127.0.0.1:8081/widgets
```

  - Get a specific widget:
```
curl -H "Authorization: access_token_secret" 127.0.0.1:8081/widgets/1
```

  - Create a new widget:
```
curl -H "Content-Type: application/json" -H "Authorization: access_token_secret" -X POST -d '{"name":"test2","color":"Yellow","price":1000,"inventory":999,"melts":true}' 127.0.1:8081/widgets
```

  - Update an existing widget:
```
curl -H "Content-Type: application/json" -H "Authorization: access_token_secret" -X PUT -d '{"name":"test4","color":"Yellow","price":1000,"inventory":999,"melts":true}' 127.0.1:8081/widgets/1
```

### Run automated test cases

It was created some test cases to execute all the APIs. The Make script will create a new database based on the same image of the production database. As it was used the same port for both databases, it requires that only one is running at the same time. So, if the production database is running, the script will stop it upon start test process. It will also avoid losting data on production database when tests are executed.

1. Create and instantiate test database

```
make test-db
```

2. Run automated tests

```
make test-app
```
It will show an ouput like this:
```
TestMain() running

ensureTablesExists() running

=== RUN   TestEmptyTableUsers
--- PASS: TestEmptyTableUsers (0.13s)
=== RUN   TestGetUsersAccessDenied
--- PASS: TestGetUsersAccessDenied (0.00s)
=== RUN   TestGetUserByIdAccessDenied
--- PASS: TestGetUserByIdAccessDenied (0.00s)
=== RUN   TestGetUserPassingInvalidId
--- PASS: TestGetUserPassingInvalidId (0.18s)
=== RUN   TestGetUser1
--- PASS: TestGetUser1 (0.31s)
=== RUN   TestGetAllUsers
--- PASS: TestGetAllUsers (0.45s)
=== RUN   TestEmptyTableWidgets
--- PASS: TestEmptyTableWidgets (0.32s)
=== RUN   TestGetWidgetsAccessDenied
--- PASS: TestGetWidgetsAccessDenied (0.00s)
=== RUN   TestGetWidgetByIdAccessDenied
--- PASS: TestGetWidgetByIdAccessDenied (0.00s)
=== RUN   TestPostWidgetAccessDenied
--- PASS: TestPostWidgetAccessDenied (0.00s)
=== RUN   TestPutWidgetAccessDenied
--- PASS: TestPutWidgetAccessDenied (0.00s)
=== RUN   TestGetWidgetPassingInvalidId
--- PASS: TestGetWidgetPassingInvalidId (0.18s)
=== RUN   TestPutWidgetPassingInvalidId
--- PASS: TestPutWidgetPassingInvalidId (0.18s)
=== RUN   TestPutWidgetWithoutData
--- PASS: TestPutWidgetWithoutData (0.18s)
=== RUN   TestPostWidget
--- PASS: TestPostWidget (0.26s)
=== RUN   TestPutWidget
--- PASS: TestPutWidget (0.06s)
=== RUN   TestGetWidget
--- PASS: TestGetWidget (0.00s)
=== RUN   TestGetAllWidgets
--- PASS: TestGetAllWidgets (0.06s)
PASS
ok  	github.com/emrachid/widgets-spa-server	2.759s
```

### Swagger documentation

It was used Swagger annotation in the handle request functions of the APIs for automatic generation of documentation. Swagger file will be generated by the `make run-app` script. It will create `swagger.json` file that is used by Swagger UI and Swagger Editor to create the documentation page. This file can accessed through the following API. The access is public and this API does not require authentication token.

- GET `/swagger.json` for getting Swagger documentation file

#### Swagger UI

It is not neccessary to run Swagger UI on server site. You can use the online version and pass your server `swagger.json` as input to view the documentation. For example, access [Swagger UI](http://petstore.swagger.io/?_ga=2.172996963.1198918188.1519261979-94583732.1518810701]) and type your server URL in the field in the top of the page (http://serverIP/swagger.json).

For running Swagger UI on server site, the following script can be used. It will run on port 8082 (http://127.0.0.1:8082).

```
make swagger-ui
```

#### Swagger Editor

Another alternative for viewing the documentation is using [Swagger Editor](https://editor.swagger.io). Access the Swagger Editor page ([click here](https://editor.swagger.io)), select File / Import File and upload your `swagger.json` file.

## License

The contents of this repository are covered under the [MIT License](LICENSE).

## Contact Me

You are welcome to contact me about any concern, ask for help, report issues, provide suggestions, good practices or anything else.

[Euler Rachid](mailto:emrachid@gmail.com)

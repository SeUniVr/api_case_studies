# SpringBoot-Rest-App-AirlineTicket

Technologies: 
-	Java 8, 
-	Spring Boot, 
-	Maven, 
-	JPA-Hibernate, 
-	MySQL, 
-	Restful WebService (Json), 
-	Swagger, 
-	Lombok (To avoid boiler plate codes like getter, setter, constructor, toString. etc.),
-	Docker (Using docker-compose to run the containers)

Back-end services:
-	Add, remove, update, delete, get, get all airport company
-	Add, remove, update, delete, get, get all airport
-	Add, remove, update, delete, get, get all flight
-	Add, remove, update, delete, get, get all plane
-	Add, remove, update, delete, get, get all route
-	Add, remove, update, delete, get, get all ticket
-	Buy ticket, search by ticket code, Cancel Ticket
-	Increase ticket price by %10 depending on the increase in flight quotes by %10, %20, %30 …

Documentation (Swagger):  http://localhost:8082/swagger-ui.html

#### Commands:
Both the application and the MySQL database are runned using docker-compose. Before starting the containers you need to package the application into a .jar (only the first time or if you modify the source code).
~~~bash
#Package
SpringBoot-Rest-App-AirlineTicket$ make package
#Start
SpringBoot-Rest-App-AirlineTicket$ make up
#Stop
SpringBoot-Rest-App-AirlineTicket$ make down
~~~
Note that you could need to run the last two commands as superuser depending on Docker configuration.

#### Commands (without make):
~~~bash
#Build the .jar
SpringBoot-Rest-App-AirlineTicket$ mvn clean
SpringBoot-Rest-App-AirlineTicket$ mvn package

#Buuild Docker images & run
SpringBoot-Rest-App-AirlineTicket$ docker-compose up -d --build

#Stop Docker containers
SpringBoot-Rest-App-AirlineTicket$ docker-compose down
~~~



#### Request Examples (JSON) :

###### Create Airport
Request:
~~~
POST: localhost:8082/api/airport
Body:
{
	"name": "Ataturk Airport",
	"capacity": 100,
	"location": "Istanbul-Avrupa"
}
~~~
Response:
~~~
Status: 200 – OK
Body:
{
    "id": 5,
    "name": "3. Havaalani",
    "capacity": 500,
    "location": "Istanbul-Avrupa",
    "departureRoutes": null,
    "arrivalRoutes": null
}
~~~
---
###### Get Airport By Id
Request:
~~~
GET: localhost:8082/api/airport/1
~~~
Response:
~~~
Status: 200 – OK
Body:
{
    "id": 1,
    "name": "Sabiha Gokcen",
    "capacity": 1000,
    "location": "Istanbul-Asya",
    "departureRoutes": [],
    "arrivalRoutes": [],
    "hibernateLazyInitializer": {}
}
~~~
---
###### Get All Airports
Request:
~~~
GET: localhost:8082/api/airport
~~~
Response:
~~~
Status: 200 – OK
Body:
[
    {
        "id": 1,
        "name": "Sabiha Gokcen Airport",
        "capacity": 1000,
        "location": "Istanbul-Asya",
        "departureRoutes": [],
        "arrivalRoutes": []
    },
    {
        "id": 2,
        "name": "Ataturk Airport",
        "capacity": 100,
        "location": "Istanbul-Avrupa",
        "departureRoutes": [],
        "arrivalRoutes": []
    }
]
~~~
---
###### Delete Airport
Request:
~~~
DELETE: localhost:8082/api/airport/2
~~~
Response:
~~~
Status: 200 – OK
~~~

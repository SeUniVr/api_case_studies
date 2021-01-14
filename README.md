# API case studies

###### [cs01_slim_tasks_notes](https://github.com/maurobonfietti/rest-api-slim-php)
**Specifica swagger valida**

Makefile sistemato

###### [cs02_airline_ticket](https://github.com/erhanhepyasar/SpringBoot-Rest-App-AirlineTicket)
**Specifica con errori semantici (credo si possa sistemare)**

Specifica sistemata, Makefile sistemato

###### [cs03_streaming](https://github.com/attacomsian/live-streaming)
**Specifica swagger valida**

Makefile sistemato, Servizio fragilissimo e un po' strano

###### [cs04_petclinic](https://github.com/spring-petclinic/spring-petclinic-rest)
**Specifica swagger valida**

Makefile sistemato

###### [cs05_toggle](https://github.com/pdonatilio/ToggleAPI)
**Specifica swagger valida**

**Gira tutto su HTTPS e le richieste HTTP le redireziona su HTTPS. Modificata una singola riga nel sorgente(commentata) per evitarlo**

Per ottenere un JWT token:
```
curl -X POST "http://localhost:8080/api/User" -H "accept: application/json" -H "Content-Type: application/json-patch+json" -d "{ \"id\": 40, \"firstName\": \"string\", \"lastName\": \"string\", \"username\": \"string\", \"password\": \"string\", \"token\": \"string\"}"
```
```
curl -X POST "http://localhost:8080/api/User/auth" -H "accept: application/json" -H "Content-Type: application/json-patch+json" -d "{ \"username\": \"string\", \"password\": \"string\"}"
```
Estrarre poi token dalla risposta (header: **Authorization: Bearer ey...**'):
```
{
  "id": 40,
  "firstName": "string",
  "lastName": "string",
  "username": "string",
  "password": null,
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjQwIiwibmJmIjoxNjEwNjIxOTk2LCJleHAiOjE2MTEyMjY3OTYsImlhdCI6MTYxMDYyMTk5Nn0.iLvhEaUUqx6oHfi6cbHbvjkn5xuHNsaEwAQSDU6sr7c"
}
```

###### [cs06_problems](https://github.com/medovuk/spring-boot-restful-api-example)
**Specifica con un singolo errore semantico ed un warning. Sembra causato da qualche carattere codicicato male, quindi si può aggiustare (applicazione coreana)**

Specifica sistemata, Makefile sistemato

###### [cs07_products](https://github.com/abhishek70/spring-boot-docker-rest-api)
**Specifica swagger con errori strutturali e semantici**

Specifica sistemata, Makefile sistemato

###### [cs08_widgets](https://github.com/emrachid/widgets-spa-server)
**Specifica swagger valida**

Makefile sistemato

Autenticazione statica con header: **Authorization: access_token_secret**

###### [cs09_safrs](https://github.com/thomaxxl/safrs)
**Specifica swagger valida**

Makefile sistemato

###### [cs10_realworld](https://github.com/gothinkster/laravel-realworld-example-app)
**Specifica swagger valida**

Makefile sistemato

Per ottenere un JWT token:
```
curl -X POST  http://localhost:8080/api/users -H "Content-Type: application/json-patch+json" -d "{ \"user\": { \"username\": \"Jacob\", \"email\": \"jake@jake.jake\", \"password\": \"jakejake\" } }"
```
```
curl -X POST "http://localhost:9090/api/users/login" -H "Content-Type: application/json-patch+json" -d "{ \"user\":{\"email\": \"jake@jake.jake\", \"password\": \"jakejake\"}}"
```
Estrarre poi token dalla risposta (header: **Authorization: Bearer ey...**')

###### [cs11_crud](https://github.com/lucianopereira86/CRUD-NodeJS-Sequelize-Swagger-MySQL)
**Specifica swagger con errori strutturali**

Makefile sistemato, Specifica sistemata

###### [cs12_order](https://github.com/jainsiddharth21/OrderAPI)
**Specifica swagger con errori strutturali**

**Attenzione! Il src/.env contiene la API key di Davide, bisogna disattivarla prima di rendere tutto pubblico**

Makefile sistemato, Specifica sistemata

###### [cs13_users](https://github.com/mateusconstanzo/express-typeorm-typescript)
**Specifica swagger con errori semantici**

Makefile sistemato, specifica sistemata

Bisognava farlo partire 2 volte. Però quando parte la seconda volta funziona. Adottata soluzione 'provvisoria' per farlo funzionare comunque con la solita sequenza di comandi.

###### [cs14_scheduler](https://github.com/carlos-illobre/node-express-swagger-docker-sequelizer)
**Specifica disastrosa. Bisogna ancora estrarla bene, ma è piena di errori strutturali e semantici**

Specifica sistemata, Makefile sistemato.

Per ottenere un JWT token:
```
curl -X POST "http://localhost:8080/api/v1/users/login" -H "accept: application/json" -H "Content-Type: application/json" -d "{ \"email\": \"admin@admin\", \"password\": \"secret\"}"
```
Estrarre poi token dalla risposta (header: **Authorization: Bearer ey...**'):

## Bugs:
- Tutti i Makefile sono da sistemare (bisogna essere sicuri che venga fatto il rebuild e che vengano eliminate le immagini anche intermedie)

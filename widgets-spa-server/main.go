// Widgets SPA API
//
// The purpose of this application is to create a backend microservice that: \
// uses a token to authenticate request, uses Golang, persists data into a SQL database, uses Docker and Swagger.
//
//     Schemes: http
//     Host: localhost:8081
//     Version: 1.0.0
//     License: MIT http://opensource.org/licenses/MIT
//     Contact: Euler Rachid <emrachid@gmail.com>
//
//     Consumes:
//     - application/json
//
//     Produces:
//     - application/json
//
// swagger:meta
package main

import (
    "fmt"
    "os"
)

func main() {
    fmt.Println("Spa application running\n")

    app := App{}

    app.OpenDb(
        os.Args[1],//"root"
        os.Args[2],//"mysql-secret-pw"
        os.Args[3],//"127.0.0.1"
        os.Args[4],//"3306"
        os.Args[5])//"spa"

    app.RouteRequests()
    
    app.Run(os.Args[6])//":8081"
}

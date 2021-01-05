package main

import (
    "database/sql"
    "encoding/json"
    "fmt"
    "github.com/gorilla/mux"
    _ "github.com/go-sql-driver/mysql"
    "log"
    "net/http"
    "strconv"
)

type App struct {
    Router *mux.Router
    Db *sql.DB
}

func (app *App) OpenDb(user, password, serverIp, serverPort, dbname string) {
    connectionString :=
        fmt.Sprintf("%s:%s@tcp(%s:%s)/%s", user, password, serverIp, serverPort, dbname)
 
    var err error
    app.Db, err = sql.Open("mysql", connectionString)
    
    if err != nil {
        panic(err.Error())
    }

    err = app.Db.Ping()
    if err != nil {
        defer app.Db.Close()
        panic(err.Error())
    }
}

func (app *App) RouteRequests() {
    app.Router = mux.NewRouter().StrictSlash(true)
    app.Router.HandleFunc("/users", app.handleGetUsers).Methods("GET")
    app.Router.HandleFunc("/users/{id:[0-9]+}", app.handleGetUserById).Methods("GET")
    app.Router.HandleFunc("/widgets", app.handleGetWidgets).Methods("GET")
    app.Router.HandleFunc("/widgets/{id:[0-9]+}", app.handleGetWidgetById).Methods("GET")
    app.Router.HandleFunc("/widgets", app.handlePostWidget).Methods("POST")
    app.Router.HandleFunc("/widgets/{id:[0-9]+}", app.handlePutWidget).Methods("PUT")
    app.Router.HandleFunc("/swagger.json", swagger).Methods("GET")

    app.Router.Use(basicAuthMiddleware)
}

func (app *App) Run(appPort string) {
    log.Fatal(http.ListenAndServe(appPort, app.Router))
}

func basicAuthMiddleware(next http.Handler) http.Handler {
  return http.HandlerFunc(func(httpWriter http.ResponseWriter, httpRequest *http.Request) {
    token := httpRequest.Header.Get("Authorization")

    if token == "access_token_secret" || httpRequest.URL.Path == "/swagger.json" {
        next.ServeHTTP(httpWriter, httpRequest)
    } else {
        http.Error(httpWriter, "Access denied", http.StatusUnauthorized)
    }
  })
}

func swagger(httpWriter http.ResponseWriter, httpRequest *http.Request) {
    httpWriter.Header().Set("Content-Type", "application/json")
    http.ServeFile(httpWriter, httpRequest, "swagger.json")
}

func (app *App) handleGetUsers(httpWriter http.ResponseWriter, httpRequest *http.Request) {
    // swagger:operation GET /users Users handleGetUsers
    //
    // Returns a list of all users
    // ---
    // consumes:
    // - application/json
    // produces:
    // - application/json
    // responses:
    //   '200':
    //     description: Success
    //     type: User.json
    //   '401':
    //     description: Access denied
    //     type: string
    //   '404':
    //     description: Not found
    //     type: string
    //   '500':
    //     description: Internal error
    //     type: string

    httpWriter.Header().Set("Content-Type", "application/json")

    users, err := GetUsers(app.Db)
    if err != nil {
        httpWriter.WriteHeader(http.StatusInternalServerError)
        log.Fatal(err.Error())
        fmt.Fprintf(httpWriter, "Internal error")
    } else {
        httpWriter.WriteHeader(http.StatusOK)
        json.NewEncoder(httpWriter).Encode(users)
    }
}

func (app *App) handleGetUserById(httpWriter http.ResponseWriter, httpRequest *http.Request) {
    // swagger:operation GET /users/{id} Users handleGetUserById
    //
    // Returns an user selected by ID
    // ---
    // consumes:
    // - application/json
    // produces:
    // - application/json
    // parameters:
    // - name: id
    //   in: path
    //   description: ID of user to be fetch
    //   required: true
    //   type: integer
    // responses:
    //   '200':
    //     description: Success
    //     type: User.json
    //   '400':
    //     description: Invalid parameter
    //     type: string
    //   '401':
    //     description: Access denied
    //     type: string
    //   '404':
    //     description: Not found
    //     type: string
    //   '500':
    //     description: Internal error
    //     type: string

    httpWriter.Header().Set("Content-Type", "application/json")

    vars := mux.Vars(httpRequest)

    id, err := strconv.Atoi(vars["id"])
    if err != nil {
        httpWriter.WriteHeader(http.StatusBadRequest)
        log.Print(err.Error())
        fmt.Fprintf(httpWriter, "Invalid parameter")
    } else {
        user, err := GetUser(app.Db, id)
        if err != nil {
            if err.Error() == "Not found" {
                httpWriter.WriteHeader(http.StatusNotFound)
                fmt.Fprintf(httpWriter, err.Error())
            } else {
                httpWriter.WriteHeader(http.StatusInternalServerError)
                log.Fatal(err.Error())
                fmt.Fprintf(httpWriter, "Internal error")
            }
        } else {
            httpWriter.WriteHeader(http.StatusOK)
            json.NewEncoder(httpWriter).Encode(user)
        }
    }
}

func (app *App) handleGetWidgets(httpWriter http.ResponseWriter, httpRequest *http.Request) {
    // swagger:operation GET /widgets Widgets handleGetWidgets
    //
    // Returns a list of all widgets
    // ---
    // consumes:
    // - application/json
    // produces:
    // - application/json
    // responses:
    //   '200':
    //     description: Success
    //     type: Widget.json
    //   '401':
    //     description: Access denied
    //     type: string
    //   '404':
    //     description: Not found
    //     type: string
    //   '500':
    //     description: Internal error
    //     type: string
    httpWriter.Header().Set("Content-Type", "application/json")

    widgets, err := getWidgets(app.Db)
    if err != nil {
        httpWriter.WriteHeader(http.StatusInternalServerError)
        log.Fatal(err.Error())
        fmt.Fprintf(httpWriter, "Internal error")
    } else {
        httpWriter.WriteHeader(http.StatusOK)
        json.NewEncoder(httpWriter).Encode(widgets)
    }
}

func (app *App) handleGetWidgetById(httpWriter http.ResponseWriter, httpRequest *http.Request) {
    // swagger:operation GET /widgets/{id} Widgets handleGetWidgetById
    //
    // Returns an widget selected by ID
    // ---
    // consumes:
    // - application/json
    // produces:
    // - application/json
    // parameters:
    // - name: id
    //   in: path
    //   description: ID of widget to be fetch
    //   required: true
    //   type: integer
    // responses:
    //   '200':
    //     description: Success
    //     type: Widget.json
    //   '400':
    //     description: Invalid parameter
    //     type: string
    //   '401':
    //     description: Access denied
    //     type: string
    //   '404':
    //     description: Not found
    //     type: string
    //   '500':
    //     description: Internal error
    //     type: string

    var id int
    var widget Widget
    var err error

    httpWriter.Header().Set("Content-Type", "application/json")

    vars := mux.Vars(httpRequest)
    if id, err = strconv.Atoi(vars["id"]); err != nil {
        httpWriter.WriteHeader(http.StatusBadRequest)
        log.Print(err.Error())
        fmt.Fprintf(httpWriter, "Invalid parameter")
        return
    }

    if widget, err = getWidget(app.Db, id); err != nil {
        if err.Error() == "Not found" {
            httpWriter.WriteHeader(http.StatusNotFound)
            fmt.Fprintf(httpWriter, err.Error())
        } else {
            httpWriter.WriteHeader(http.StatusInternalServerError)
            log.Fatal(err.Error())
            fmt.Fprintf(httpWriter, "Internal error")
        }
        return
    }

    httpWriter.WriteHeader(http.StatusOK)
    json.NewEncoder(httpWriter).Encode(widget)
}

func (app *App) handlePostWidget(httpWriter http.ResponseWriter, httpRequest *http.Request) {
    // swagger:operation POST /widgets Widgets handlePostWidget
    //
    // Creates a new widget and returns the widgets including its new assigned ID
    // ---
    // consumes:
    // - application/json
    // produces:
    // - application/json
    // responses:
    //   '200':
    //     description: Success
    //     type: Widget.json
    //   '401':
    //     description: Access denied
    //     type: string
    //   '404':
    //     description: Not found
    //     type: string
    //   '500':
    //     description: Internal error
    //     type: string
    var widget Widget

    if (httpRequest.Body == nil) {
        httpWriter.WriteHeader(http.StatusBadRequest)
        fmt.Fprintf(httpWriter, "Invalid data")
        return
    }
    defer httpRequest.Body.Close()
    decoder := json.NewDecoder(httpRequest.Body)
    if err := decoder.Decode(&widget); err != nil {
        httpWriter.WriteHeader(http.StatusBadRequest)
        log.Print(err.Error())
        fmt.Fprintf(httpWriter, "Invalid data")
        return
    }

    if err := widget.insertWidget(app.Db); err != nil {
        httpWriter.WriteHeader(http.StatusInternalServerError)
        log.Fatal(err.Error())
        fmt.Fprintf(httpWriter, "Internal error")
        return
    }

    httpWriter.WriteHeader(http.StatusOK)
    json.NewEncoder(httpWriter).Encode(widget)
}

func (app *App) handlePutWidget(httpWriter http.ResponseWriter, httpRequest *http.Request) {
    // swagger:operation PUT /widgets/{id} Widgets handlePutWidget
    //
    // Updates an widget selected by its ID and returns it updated
    // ---
    // consumes:
    // - application/json
    // produces:
    // - application/json
    // parameters:
    // - name: id
    //   in: path
    //   description: ID of widget to be updated
    //   required: true
    //   type: integer
    // responses:
    //   '200':
    //     description: Success
    //     type: Widget.json
    //   '400':
    //     description: Invalid parameter
    //     type: string
    //   '401':
    //     description: Access denied
    //     type: string
    //   '404':
    //     description: Not found
    //     type: string
    //   '500':
    //     description: Internal error
    //     type: string

    vars := mux.Vars(httpRequest)
    id, err := strconv.Atoi(vars["id"])
    if err != nil {
        httpWriter.WriteHeader(http.StatusBadRequest)
        log.Print(err.Error())
        fmt.Fprintf(httpWriter, "Invalid parameter")
        return
    }

    var widget Widget
    if (httpRequest.Body == nil) {
        httpWriter.WriteHeader(http.StatusBadRequest)
        fmt.Fprintf(httpWriter, "Invalid data")
        return
    }
    defer httpRequest.Body.Close()
    decoder := json.NewDecoder(httpRequest.Body)
    if err := decoder.Decode(&widget); err != nil {
        httpWriter.WriteHeader(http.StatusBadRequest)
        log.Print(err.Error())
        fmt.Fprintf(httpWriter, "Invalid data")
        return
    }

    widget.Id = uint(id)

    err = widget.updateWidget(app.Db)
    if err != nil {
        if (err.Error() == "Data not updated") {
            httpWriter.WriteHeader(http.StatusBadRequest)
            fmt.Fprintf(httpWriter, "Data not updated")
            return
        }
        httpWriter.WriteHeader(http.StatusInternalServerError)
        log.Fatal(err.Error())
        fmt.Fprintf(httpWriter, "Internal error")
        return
    }

    httpWriter.WriteHeader(http.StatusOK)
    json.NewEncoder(httpWriter).Encode(widget)
}

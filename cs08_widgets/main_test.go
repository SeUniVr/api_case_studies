package main_test

import (
    "fmt"
    "github.com/emrachid/widgets-spa-server"
    "log"
    "os"
    "testing"
)

const createTableUsers = `CREATE TABLE IF NOT EXISTS users
(
    id int NOT NULL AUTO_INCREMENT,
    name varchar(100),
    gravatar varchar(2083),
    PRIMARY KEY (id)
)`

const createTableWidgets = `CREATE TABLE IF NOT EXISTS widgets
(
    id int NOT NULL AUTO_INCREMENT,
    name varchar(100),
    color varchar(30),
    price decimal(20,2) unsigned zerofill,
    inventory int unsigned NOT NULL,
    melts bool DEFAULT 0,
    PRIMARY KEY (id)
)`

var app main.App

func TestMain(m *testing.M) {
    fmt.Println("TestMain() running\n")

    app = main.App{}

    app.OpenDb(
        "root",
        "mysql-secret-pw",
        "127.0.0.1",
        "3306",
        "spa")

    app.RouteRequests()

    ensureTablesExists()

    code := m.Run()

    clearUsersTable()
    clearWidgetsTable()

    os.Exit(code)
}

func ensureTablesExists() {
    fmt.Println("ensureTablesExists() running\n")
    if _, err := app.Db.Exec(createTableUsers); err != nil {
        log.Fatal(err)
    }

    if _, err := app.Db.Exec(createTableWidgets); err != nil {
        log.Fatal(err)
    }
}

func clearUsersTable() {
    app.Db.Exec("DELETE FROM users")
    app.Db.Exec("ALTER TABLE users AUTO_INCREMENT = 1")

    app.Db.Exec("DELETE FROM widgets")
    app.Db.Exec("ALTER TABLE widgets AUTO_INCREMENT = 1")
}

func clearWidgetsTable() {
    app.Db.Exec("DELETE FROM users")
    app.Db.Exec("ALTER TABLE users AUTO_INCREMENT = 1")

    app.Db.Exec("DELETE FROM widgets")
    app.Db.Exec("ALTER TABLE widgets AUTO_INCREMENT = 1")
}

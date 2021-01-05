package main_test

import (
    "encoding/json"
    "net/http"
    "net/http/httptest"
    "testing"
    . "github.com/emrachid/widgets-spa-server"
)

const insertUser1 = `INSERT INTO users (name, gravatar) VALUES
(
    "user1",
    "https://gravatar.com/user1"
)`

const insertUser2 = `INSERT INTO users (name, gravatar) VALUES
(
    "user2",
    "https://gravatar.com/user2"
)`

func insertDataIntoUsersTable() {
    app.Db.Exec(insertUser1)
    app.Db.Exec(insertUser2)
}

func TestEmptyTableUsers(t *testing.T) {
    clearUsersTable()

    req, _ := http.NewRequest("GET", "/users", nil)
    req.Header.Set("Authorization","access_token_secret")
    rr := httptest.NewRecorder()
    app.Router.ServeHTTP(rr, req)

    if http.StatusOK != rr.Code {
        t.Errorf("Expected response code %d. Got %d\n", http.StatusOK, rr.Code)
    }

    if body := rr.Body.String(); body[:len(body)-1] != "[]" {
        t.Errorf("Expected an empty array. Got %s", body)
    }
}

func TestGetUsersAccessDenied(t *testing.T) {
    req, _ := http.NewRequest("GET", "/users", nil)
    rr := httptest.NewRecorder()
    app.Router.ServeHTTP(rr, req)

    if http.StatusUnauthorized != rr.Code {
        t.Errorf("Expected response code %d. Got %d\n", http.StatusUnauthorized, rr.Code)
    }
}

func TestGetUserByIdAccessDenied(t *testing.T) {
    req, _ := http.NewRequest("GET", "/users/1", nil)
    rr := httptest.NewRecorder()
    app.Router.ServeHTTP(rr, req)

    if http.StatusUnauthorized != rr.Code {
        t.Errorf("Expected response code %d. Got %d\n", http.StatusUnauthorized, rr.Code)
    }
}
func TestGetUserPassingInvalidId(t *testing.T) {
    clearUsersTable()

    req, _ := http.NewRequest("GET", "/users/1", nil)
    req.Header.Set("Authorization","access_token_secret")
    rr := httptest.NewRecorder()
    app.Router.ServeHTTP(rr, req)

    if http.StatusNotFound != rr.Code {
        t.Errorf("Expected response code %d. Got %d\n", http.StatusNotFound, rr.Code)
    }
}

func TestGetUser1(t *testing.T) {
    clearUsersTable()

    insertDataIntoUsersTable()

    req, _ := http.NewRequest("GET", "/users/1", nil)
    req.Header.Set("Authorization","access_token_secret")
    rr := httptest.NewRecorder()
    app.Router.ServeHTTP(rr, req)

    if http.StatusOK != rr.Code {
        t.Errorf("Expected response code %d. Got %d\n", http.StatusOK, rr.Code)
    }

    var user1 User
    decoder := json.NewDecoder(rr.Body)
    if err := decoder.Decode(&user1); err != nil {
        t.Errorf("Expected response code %s. Got %s\n", "user1", err.Error())
    }

    if user1.Name != "user1" || 
       user1.Gravatar != "https://gravatar.com/user1" {
        t.Errorf("Expected response code %s. Got %v\n", "user1", user1)
    }    
}

func TestGetAllUsers(t *testing.T) {
    clearUsersTable()

    insertDataIntoUsersTable()

    req, _ := http.NewRequest("GET", "/users", nil)
    req.Header.Set("Authorization","access_token_secret")
    rr := httptest.NewRecorder()
    app.Router.ServeHTTP(rr, req)

    if http.StatusOK != rr.Code {
        t.Errorf("Expected response code %d. Got %d\n", http.StatusOK, rr.Code)
    }

    var users []User
    decoder := json.NewDecoder(rr.Body)
    if err := decoder.Decode(&users); err != nil {
        t.Errorf("Expected response code %s. Got %s\n", "user1", err.Error())
    }

    if len(users) != 2 {
        t.Errorf("Expected two users. Got %d\n", len(users))
    }

    if users[0].Name != "user1" || 
       users[0].Gravatar != "https://gravatar.com/user1" {
        t.Errorf("Expected response code %s. Got %v\n", "user1", users[0])
    }

    if users[1].Name != "user2" || 
       users[1].Gravatar != "https://gravatar.com/user2" {
        t.Errorf("Expected response code %s. Got %v\n", "user2", users[1])
    }
}

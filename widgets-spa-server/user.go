package main

import (
    "database/sql"
    "errors"
    _ "github.com/go-sql-driver/mysql"
)

type User struct {
    Id       uint   `json:"id"`
    Name     string `json:"name"`
    Gravatar string `json:"gravatar"`
}

func GetUser(db *sql.DB, id int) (User, error) {
    var user User

    row, err := db.Query("SELECT * FROM users where id = ?", id)
    if err != nil {
        return user, err
    }

    defer row.Close()
    
    if row.Next() {
        err := row.Scan(&user.Id, &user.Name, &user.Gravatar)
        if err != nil {
            return user, err
        }
    } else {
        return user, errors.New("Not found")
    }

    err = row.Err()
    if err != nil {
        return user, err
    }

    return user, nil
}

func GetUsers(db *sql.DB) ([]User, error) {
    users := []User{}

    rows, err := db.Query("SELECT * FROM users")
    if err != nil {
        return nil, err
    }

    defer rows.Close()

    for rows.Next() {
        var user User
        // for each row, scan the result into our tag composite object
        err = rows.Scan(&user.Id, &user.Name, &user.Gravatar)
        if err != nil {
            return nil, err
        }
        users = append(users, user)
    }
    err = rows.Err()
    if err != nil {
        return nil, err
    }

    return users, nil
}

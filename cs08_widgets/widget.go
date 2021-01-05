package main

import (
    "database/sql"
    "errors"
    _ "github.com/go-sql-driver/mysql"
)

// A Widget model.
//
// This is used for passing a widget as body of the request
// swagger:parameters handlePostWidget handlePutWidget
type Widget struct {
    Id        uint    `json:"id"`
    Name      string  `json:"name"`
    Color     string  `json:"color"`
    Price     float32 `json:"price"`
    Inventory uint    `json:"inventory"`
    Melts     bool    `json:"melts"`
}

func (widget *Widget) insertWidget(db *sql.DB) error {
    stmt, err := db.Prepare(`INSERT INTO widgets(name,
                                                 color,
                                                 price,
                                                 inventory,
                                                 melts) VALUES(?,?,?,?,?)`)
    if err != nil {
        return err
    }

    res, err := stmt.Exec(widget.Name, widget.Color, widget.Price, widget.Inventory, widget.Melts)
    if err != nil {
        return err
    }
    
    lastId, err := res.LastInsertId()
    if err != nil {
        return err
    }
    
    widget.Id = uint(lastId)

    return nil
}

func (widget *Widget) updateWidget(db *sql.DB) error {
    stmt, err := db.Prepare(`UPDATE widgets SET name=?,
                                                color=?,
                                                price=?,
                                                inventory=?,
                                                melts=? WHERE id = ?`)
    if err != nil {
        return err
    }

    res, err := stmt.Exec(widget.Name,
                          widget.Color,
                          widget.Price,
                          widget.Inventory,
                          widget.Melts,
                          widget.Id)
    if err != nil {
        return err
    }

    rowCnt, err := res.RowsAffected()
    if err != nil {
        return err
    }
    if rowCnt != 1 {
        return errors.New("Data not updated")
    }
    
    return nil
}

func getWidget(db *sql.DB, id int) (Widget, error) {
    var widget Widget

    row, err := db.Query("SELECT * FROM widgets where id = ?", id)
    if err != nil {
        return widget, err
    }

    defer row.Close()
    
    if row.Next() {
        // for each row, scan the result into our tag composite object
        err = row.Scan(&widget.Id,
                       &widget.Name,
                       &widget.Color,
                       &widget.Price,
                       &widget.Inventory,
                       &widget.Melts)
        if err != nil {
            return widget, err
        }
    } else {
        return widget, errors.New("Not found")
    }

    err = row.Err()
    if err != nil {
        return widget, err
    }

    return widget, nil
}

func getWidgets(db *sql.DB) ([]Widget, error) {
    widgets := []Widget{}

    rows, err := db.Query("SELECT * FROM widgets")
    if err != nil {
        return nil, err
    }

    defer rows.Close()

    for rows.Next() {
        var widget Widget

        // for each row, scan the result into our tag composite object
        err = rows.Scan(&widget.Id,
                        &widget.Name,
                        &widget.Color,
                        &widget.Price,
                        &widget.Inventory,
                        &widget.Melts)
        if err != nil {
            return nil, err
        }
        widgets = append(widgets, widget)
    }
    err = rows.Err()
    if err != nil {
        return nil, err
    }

    return widgets, nil
}

package main_test

import (
    "bytes"
    "encoding/json"
    "net/http"
    "net/http/httptest"
    "testing"
    . "github.com/emrachid/widgets-spa-server"
)

func TestEmptyTableWidgets(t *testing.T) {
    clearWidgetsTable()

    req, _ := http.NewRequest("GET", "/widgets", nil)
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

func TestGetWidgetsAccessDenied(t *testing.T) {
    req, _ := http.NewRequest("GET", "/widgets", nil)
    rr := httptest.NewRecorder()
    app.Router.ServeHTTP(rr, req)

    if http.StatusUnauthorized != rr.Code {
        t.Errorf("Expected response code %d. Got %d\n", http.StatusUnauthorized, rr.Code)
    }
}

func TestGetWidgetByIdAccessDenied(t *testing.T) {
    req, _ := http.NewRequest("GET", "/widgets/1", nil)
    rr := httptest.NewRecorder()
    app.Router.ServeHTTP(rr, req)

    if http.StatusUnauthorized != rr.Code {
        t.Errorf("Expected response code %d. Got %d\n", http.StatusUnauthorized, rr.Code)
    }
}

func TestPostWidgetAccessDenied(t *testing.T) {
    req, _ := http.NewRequest("POST", "/widgets", nil)
    rr := httptest.NewRecorder()
    app.Router.ServeHTTP(rr, req)

    if http.StatusUnauthorized != rr.Code {
        t.Errorf("Expected response code %d. Got %d\n", http.StatusUnauthorized, rr.Code)
    }
}

func TestPutWidgetAccessDenied(t *testing.T) {
    req, _ := http.NewRequest("PUT", "/widgets/1", nil)
    rr := httptest.NewRecorder()
    app.Router.ServeHTTP(rr, req)

    if http.StatusUnauthorized != rr.Code {
        t.Errorf("Expected response code %d. Got %d\n", http.StatusUnauthorized, rr.Code)
    }
}

func TestGetWidgetPassingInvalidId(t *testing.T) {
    clearWidgetsTable()

    req, _ := http.NewRequest("GET", "/widgets/1", nil)
    req.Header.Set("Authorization","access_token_secret")
    rr := httptest.NewRecorder()
    app.Router.ServeHTTP(rr, req)

    if http.StatusNotFound != rr.Code {
        t.Errorf("Expected response code %d. Got %d\n", http.StatusNotFound, rr.Code)
    }
}

func TestPutWidgetPassingInvalidId(t *testing.T) {
    clearWidgetsTable()

    widgetStr := `{"name":"widget name",
                   "color":"black",
                   "price":11.22,
                   "inventory":80,
                   "melts":true}`

    widgetByte := []byte(widgetStr)

    req, _ := http.NewRequest("PUT", "/widgets/1", bytes.NewBuffer(widgetByte))
    req.Header.Set("Authorization","access_token_secret")
    rr := httptest.NewRecorder()
    app.Router.ServeHTTP(rr, req)

    if http.StatusBadRequest != rr.Code {
        t.Errorf("Expected response code %d. Got %d\n", http.StatusBadRequest, rr.Code)
    }
}

func TestPutWidgetWithoutData(t *testing.T) {
    clearWidgetsTable()

    req, _ := http.NewRequest("PUT", "/widgets/1", nil)
    req.Header.Set("Authorization","access_token_secret")
    rr := httptest.NewRecorder()
    app.Router.ServeHTTP(rr, req)

    if http.StatusBadRequest != rr.Code {
        t.Errorf("Expected response code %d. Got %d\n", http.StatusBadRequest, rr.Code)
    }
}

func TestPostWidget(t *testing.T) {
    clearWidgetsTable()

    widgetStr := `{"name":"widget name","color":"black","price":11.22,"inventory":80,"melts":true}`
    widgetByte := []byte(widgetStr)

    req, _ := http.NewRequest("POST", "/widgets", bytes.NewBuffer(widgetByte))
    req.Header.Set("Authorization","access_token_secret")
    rr := httptest.NewRecorder()
    app.Router.ServeHTTP(rr, req)

    if http.StatusOK != rr.Code {
        t.Errorf("Expected response code %d. Got %d\n", http.StatusOK, rr.Code)
    }

    var newWidget Widget
    decoder := json.NewDecoder(rr.Body)
    if err := decoder.Decode(&newWidget); err != nil {
        t.Errorf("Expected response code %s. Got %s\n", widgetStr, err.Error())
    }

    if newWidget.Name != "widget name" || 
       newWidget.Color != "black" || 
       newWidget.Price != 11.22 ||
       newWidget.Inventory != 80 ||
       newWidget.Melts != true {
        t.Errorf("Expected response code %s. Got %v\n", widgetStr, newWidget)
    }
}

func TestPutWidget(t *testing.T) {
    // Do not clear table
    // This test should be executed after: TestPostWidget
    // update inserted widget from previous test
    widgetStr := `{"name":"test","color":"yellow","price":12,"inventory":8,"melts":false}`
    widgetByte := []byte(widgetStr)

    req, _ := http.NewRequest("PUT", "/widgets/1", bytes.NewBuffer(widgetByte))
    req.Header.Set("Authorization","access_token_secret")
    rr := httptest.NewRecorder()
    app.Router.ServeHTTP(rr, req)

    if http.StatusOK != rr.Code {
        t.Errorf("Expected response code %d. Got %d\n", http.StatusOK, rr.Code)
    }

    var newWidget Widget
    decoder := json.NewDecoder(rr.Body)
    if err := decoder.Decode(&newWidget); err != nil {
        t.Errorf("Expected response code %s. Got %s\n", widgetStr, err.Error())
    }

    if newWidget.Name != "test" || 
       newWidget.Color != "yellow" || 
       newWidget.Price != 12 ||
       newWidget.Inventory != 8 ||
       newWidget.Melts != false {
        t.Errorf("Expected response code %s. Got %v\n", widgetStr, newWidget)
    }
}

func TestGetWidget(t *testing.T) {
    // Do not clear table
    // This test should be executed after: TestPutWidget
    // update inserted widget from previous test
    widgetStr := `{"name":"test","color":"yellow","price":12,"inventory":8,"melts":false}`

    req, _ := http.NewRequest("GET", "/widgets/1", nil)
    req.Header.Set("Authorization","access_token_secret")
    rr := httptest.NewRecorder()
    app.Router.ServeHTTP(rr, req)

    if http.StatusOK != rr.Code {
        t.Errorf("Expected response code %d. Got %d\n", http.StatusOK, rr.Code)
    }

    var newWidget Widget
    decoder := json.NewDecoder(rr.Body)
    if err := decoder.Decode(&newWidget); err != nil {
        t.Errorf("Expected response code %s. Got %s\n", widgetStr, err.Error())
    }

    if newWidget.Name != "test" || 
       newWidget.Color != "yellow" || 
       newWidget.Price != 12 ||
       newWidget.Inventory != 8 ||
       newWidget.Melts != false {
        t.Errorf("Expected response code %s. Got %v\n", widgetStr, newWidget)
    }
}

func TestGetAllWidgets(t *testing.T) {
    // Do not clear tables
    // This test should be executed after: TestPutWidget
    // update inserted widget from previous test

    // Add one more widget for testing receiving more than one widget
    widgetStr1 := `{"name":"test","color":"yellow","price":12,"inventory":8,"melts":false}`
    widgetStr2 := `{"name":"widget name","color":"black","price":11.22,"inventory":80,"melts":true}`
    widgetByte := []byte(widgetStr2)

    req, _ := http.NewRequest("POST", "/widgets", bytes.NewBuffer(widgetByte))
    req.Header.Set("Authorization","access_token_secret")
    rr := httptest.NewRecorder()
    app.Router.ServeHTTP(rr, req)

    if http.StatusOK != rr.Code {
        t.Errorf("Expected response code %d. Got %d\n", http.StatusOK, rr.Code)
    }

    req, _ = http.NewRequest("GET", "/widgets", nil)
    req.Header.Set("Authorization","access_token_secret")
    rr = httptest.NewRecorder()
    app.Router.ServeHTTP(rr, req)

    if http.StatusOK != rr.Code {
        t.Errorf("Expected response code %d. Got %d\n", http.StatusOK, rr.Code)
    }

    var widgets []Widget
    decoder := json.NewDecoder(rr.Body)
    if err := decoder.Decode(&widgets); err != nil {
        t.Errorf("Unexpected error: %s\n", err.Error())
    }

    if len(widgets) != 2 {
        t.Errorf("Expected two widgets. Got %d\n", len(widgets))
    }

    if widgets[0].Name != "test" || 
       widgets[0].Color != "yellow" || 
       widgets[0].Price != 12 ||
       widgets[0].Inventory != 8 ||
       widgets[0].Melts != false {
        t.Errorf("Expected response code %s. Got %v\n", widgetStr1, widgets[0])
    }

    if widgets[1].Name != "widget name" || 
       widgets[1].Color != "black" || 
       widgets[1].Price != 11.22 ||
       widgets[1].Inventory != 80 ||
       widgets[1].Melts != true {
        t.Errorf("Expected response code %s. Got %v\n", widgetStr2, widgets[1])
    }
}

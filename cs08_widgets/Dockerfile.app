FROM golang:latest

WORKDIR /go/src/github.com/emrachid/widgets-spa-server

RUN go get -u github.com/go-swagger/go-swagger/cmd/swagger

COPY . .

RUN go get -d -v ./...
RUN go install -v ./...
RUN swagger generate spec -o ./swagger.json

CMD widgets-spa-server root $MYSQL_ROOT_PASSWORD $MYSQL_HOST 3306 $MYSQL_DATABASE :8081

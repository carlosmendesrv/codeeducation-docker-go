
FROM golang:1.15-alpine as builder

WORKDIR /go/src/app

COPY . .

RUN go build -ldflags "-w" main.go

RUN go get -d -v ./...
RUN go install -v ./...

FROM scratch
WORKDIR /go/src/app
COPY --from=builder /go/src/app .

CMD ["./main"]
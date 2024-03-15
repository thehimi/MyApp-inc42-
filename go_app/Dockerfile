FROM golang:alpine AS builder

WORKDIR /app

#Build your project first then hit Dockerfile or build your go project in dockerfile
COPY go.mod ./
RUN go mod download

COPY . .
RUN go build -o main .

FROM alpine

RUN apt update && apt -y upgrade

ENTRYPOINT ["./main"]
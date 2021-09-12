FROM alpine:latest

WORKDIR /data

RUN apk add --no-cache git openssh


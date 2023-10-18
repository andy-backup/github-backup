FROM alpine:latest

WORKDIR /data

RUN apk add --no-cache curl openssh

COPY start.sh .
COPY cron.sh .

ENTRYPOINT ["sh", "/data/start.sh"]

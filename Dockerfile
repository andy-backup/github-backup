FROM alpine:latest

WORKDIR /data

RUN apk add --no-cache curl

COPY start.sh .
COPY cron.sh .

ENTRYPOINT ["sh", "/data/start.sh"]

#!/bin/bash
set -e

echo `date`"|start"

wget $SNAPSHOT_URL -O /data/snapshot.log
SNAPSHOT_FOLDER=/data/local/snapshots
SNAPSHOT_FILE=$(ls $SNAPSHOT_FOLDER/*.bin -t | head -1)

if [ ! -f $SNAPSHOT_FILE ];then
  echo "SNAPSHOT_FILE doesn't exist"
  exit 1
fi

curl -X PUT $UPLOAD_URL/$(date +%Y%m%d).bin -i -k --header "X-Custom-Auth-Key: $AUTH_KEY_SECRET" --data-binary "@$SNAPSHOT_FILE"
curl -X PUT $UPLOAD_URL/latest.bin -i -k --header "X-Custom-Auth-Key: $AUTH_KEY_SECRET" --data-binary "@$SNAPSHOT_FILE"
rm -f $SNAPSHOT_FOLDER/*
echo `date`"|end"

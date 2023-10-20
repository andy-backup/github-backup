#!/bin/bash
set -e

echo `date`"|start"

wget $SNAPSHOT_URL -O /data/snapshot.log
SNAPSHOT_FOLDER=/data/local/snapshots
SNAPSHOT_FILE=$(ls $SNAPSHOT_FOLDER/*.bin -t | head -1)
TARGET=$1
UPLOAD_FILE_URL=$UPLOAD_URL/$(date +%Y%m%d).bin

if [ ! -f $SNAPSHOT_FILE ];then
  echo "SNAPSHOT_FILE doesn't exist"
  exit 1
fi

if [ $TARGET = "latest" ];then
  UPLOAD_FILE_URL=$UPLOAD_URL/latest.bin
fi

echo `date`"|"$UPLOAD_FILE_URL
curl -X PUT $UPLOAD_FILE_URL -i -k --header "X-Custom-Auth-Key: $AUTH_KEY_SECRET" --data-binary "@$SNAPSHOT_FILE"

rm -f $SNAPSHOT_FOLDER/*
echo `date`"|end"

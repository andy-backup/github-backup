#!/bin/bash
set -e

echo "Version 2.0.10"
echo "$(date) Start $TARGET"

RETRY_COUNT=5
RETRY_DELAY=5

wget $SNAPSHOT_URL -O /data/snapshot.log
SNAPSHOT_FOLDER=/data/local/snapshots
SNAPSHOT_FILE=$(ls $SNAPSHOT_FOLDER/*.bin -t | head -1)
TARGET=$1
UPLOAD_FILE_URL=$UPLOAD_URL/$(date +%Y%m%d).bin

if [ ! -f $SNAPSHOT_FILE ]; then
  echo "SNAPSHOT_FILE Doesn't exist"
  exit 1
fi

if [ $TARGET = "latest" ]; then
  UPLOAD_FILE_URL=$UPLOAD_URL/latest.bin
fi

echo "$(date) | $UPLOAD_FILE_URL"

# Retry loop
for ((i=1; i<=RETRY_COUNT; i++)); do
  echo "$(date) Attempt $i"
  if curl -X PUT $UPLOAD_FILE_URL -i -k --header "X-Custom-Auth-Key: $AUTH_KEY_SECRET" --data-binary "@$SNAPSHOT_FILE"; then
    echo "$(date) Upload successful"
    break
  else
    echo "$(date) Upload failed. Retrying in $RETRY_DELAY seconds..."
    sleep $RETRY_DELAY
  fi
done

rm -f $SNAPSHOT_FOLDER/*
echo "$(date) Done"

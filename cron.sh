#!/bin/sh

date
wget $SNAPSHOT_URL
SNAPSHOT_FOLDER=/data/local
SNAPSHOT_FILE=$(ls $SNAPSHOT_FOLDER/*.bin -t | head -1)
cp $SNAPSHOT_FILE /data/github/snapshot.bin
cd /data/github
git add .
git commit -m "update"
git push
rm -f $SNAPSHOT_FOLDER/*
echo 'done.'
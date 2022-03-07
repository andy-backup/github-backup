#!/bin/bash
set -e

date
wget $SNAPSHOT_URL -O /data/snapshot.log
SNAPSHOT_FOLDER=/data/local/snapshots
SNAPSHOT_FILE=$(ls $SNAPSHOT_FOLDER/*.bin -t | head -1)

if [ ! -f $SNAPSHOT_FILE ];then
  echo "SNAPSHOT_FILE doesn't exist"
  exit 1
fi

cd /data/github

cp $SNAPSHOT_FILE /data/github/snapshot.bin

git checkout --orphan latest_branch
git add .
git commit -am "update"
git branch -D master
git branch -m master
git push -f origin master

rm -f $SNAPSHOT_FOLDER/*
echo 'done.'
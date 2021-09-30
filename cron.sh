#!/bin/sh

date
wget $SNAPSHOT_URL -O /data/snapshot.log
SNAPSHOT_FOLDER=/data/local
SNAPSHOT_FILE=$(ls $SNAPSHOT_FOLDER/*.bin -t | head -1)
cp $SNAPSHOT_FILE /data/github/snapshot.bin
cd /data/github

git checkout --orphan latest_branch
git add -A
git commit -am "update"
git branch -D master
git branch -m master
git push -f origin master

rm -f $SNAPSHOT_FOLDER/*
echo 'done.'
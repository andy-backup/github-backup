#!/bin/bash
set -e

if [ ! -d /root/.ssh ];then
  mkdir /root/.ssh
fi

cp /data/.ssh/id_rsa /root/.ssh
cp /data/.ssh/id_rsa.pub /root/.ssh
chmod 400 /root/.ssh/id_rsa /root/.ssh/id_rsa.pub

echo -e "Host github.com\n\tStrictHostKeyChecking no\n" > ~/.ssh/config

git config --global user.email $GIT_USER_EMAIL
git config --global user.name $GIT_USER_NAME
git config --global init.defaultBranch master

if [ ! -d ./github ];then
  mkdir ./github
  cd ./github
  git init
  git remote add origin $GITHUB
  echo init > init
  git add .
  git commit -am "update"
  rm init

  echo "$CRON sh /data/cron.sh" >> /var/spool/cron/crontabs/root
fi

sleep 10m

sh /data/cron.sh

crond -f

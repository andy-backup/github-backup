mkdir /root/.ssh/
cp /data/.ssh/id_rsa /root/.ssh
cp /data/.ssh/id_rsa.pub /root/.ssh
chmod 400 /root/.ssh/id_rsa /root/.ssh/id_rsa.pub

echo -e "Host github.com\n\tStrictHostKeyChecking no\n" > ~/.ssh/config

git config --global user.email $GIT_USER_EMAIL
git config --global user.name $GIT_USER_NAME
git config --global init.defaultBranch master

mkdir ./github
cd ./github
git init
git remote add origin $GITHUB
git branch -M master

echo "$CRON /data/cron.sh" >> /var/spool/cron/crontabs/root

/data/cron.sh

crond -f
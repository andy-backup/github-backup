mkdir /root/.ssh/
cp /data/.ssh/id_rsa /root/.ssh
cp /data/.ssh/id_rsa.pub /root/.ssh
chmod 400 /root/.ssh/id_rsa /root/.ssh/id_rsa.pub

echo -e "Host github.com\n\tStrictHostKeyChecking no\n" > ~/.ssh/config
git clone --depth=1 $GITHUB ./github
git config --global user.email $GIT_USER_EMAIL
git config --global user.name $GIT_USER_NAME

#     min   hour    day     month   weekday command
echo "0     *       *       *       *       /data/cron.sh" >> /var/spool/cron/crontabs/root

./cron.sh

crond -f
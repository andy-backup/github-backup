GITHUB=git@github.com:andy-backup/fibos.git
echo -e "Host github.com\n\tStrictHostKeyChecking no\n" > ~/.ssh/config
git clone --depth=1 $GITHUB ./github
git config --global user.email "mingfun.wong.chn@gmail.com"
git config --global user.name "Mingfun Wong"

#     min   hour    day     month   weekday command
echo "0     *       *       *       *       /data/cron.sh" >> /var/spool/cron/crontabs/root

./cron.sh

crond -f
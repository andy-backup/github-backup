#!/bin/bash
set -e

echo "" > /var/spool/cron/crontabs/root
echo "$CRON_ARCHIVE bash /data/cron.sh archive" >> /var/spool/cron/crontabs/root
echo "$CRON_LATEST bash /data/cron.sh latest" >> /var/spool/cron/crontabs/root

sleep 10m

bash /data/cron.sh latest

crond -f

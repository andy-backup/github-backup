#!/bin/bash
set -e

echo "" > /var/spool/cron/crontabs/root
echo "$CRON_ARCHIVE sh /data/cron.sh archive" >> /var/spool/cron/crontabs/root
echo "$CRON_LATEST sh /data/cron.sh latest" >> /var/spool/cron/crontabs/root

sleep 10m

sh /data/cron.sh latest

crond -f

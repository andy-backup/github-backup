#!/bin/bash
set -e

echo "$CRON sh /data/cron.sh" > /var/spool/cron/crontabs/root

sleep 10m

sh /data/cron.sh

crond -f

#!/usr/bin/env bash

cp power_supply /usr/bin/.
chmod 755 /usr/bin/power_supply
cp UPS_LOW_BATTERY_SHUTDOWN.sh /usr/sbin/.
chmod 700 /usr/sbin/UPS_LOW_BATTERY_SHUTDOWN.sh

crontab -l > ups_cron_tmp
echo "* * * * * UPS_LOW_BATTERY_SHUTDOWN.sh" >> ups_cron_tmp
#install new cron file
crontab ups_cron_tmp
rm ups_cron_tmp
#!/usr/bin/env bash
# This script is for cron
#


DATE=`date +"%Y.%m.%d %T"`

BATTERY_CONNECTED=`power_supply BATTERY_CONNECTED`
if [ $BATTERY_CONNECTED != 1 ] ; then
	echo "Battery not connected!"
    exit
fi


BATTERY_ONLINE=`power_supply BATTERY_ONLINE`
if [[ $BATTERY_ONLINE -eq 0 ]] ; then
	echo "Battery not consumed!"
    exit
fi

if [[ $BATTERY_VOLTAGE -le 3600 ]]
then
	BATTERY_VOLTAGE_DECIMAL=$(echo "scale=2; ${BATTERY_VOLTAGE}/1000"|bc -l)V
    echo -e "######################################################
#   $DATE: Low battery capacity: $BATTERY_LEVEL%   #
#   Low battery voltage: $BATTERY_VOLTAGE_DECIMAL                       #
#   System shuts down now!                           #
######################################################
" >> /var/log/ups.log
    shutdown -h now
    exit 0;
fi
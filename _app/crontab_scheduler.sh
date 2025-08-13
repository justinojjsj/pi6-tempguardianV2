#!/bin/bash

crontab -l > mycron
#echo minute hour day_of_month month day_of_weeek command
echo "0,10,20,30,40,50 * * * * /app/script_executor.sh" > mycron
crontab mycron
rm mycron

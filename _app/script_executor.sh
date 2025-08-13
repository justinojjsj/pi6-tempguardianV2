#!/bin/bash

#Variables
python_e="/usr/local/bin/python"
capture_temperature="/app/capture_temperature.py"
date_hour=$(date '+%y/%m/%d %H:%M:%S')
space=" "
log_archive="execution_history.log"

#Script
cd /app
$python_e $capture_temperature

if [ $? -eq 0 ]; then
    success="Executed successfully"
else
    success="Not executed"
fi

# Logs the execution into the log file
echo $date_hour$space$capture_temperature$space$success >> $log_archive
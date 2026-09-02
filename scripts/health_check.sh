#!/bin/bash

Threshold=80
health_check=0
current_disk_usage=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')

if [[ $current_disk_usage -ge $Threshold ]]
then
	echo "FAIL"
	health_check=1
else
	echo "PASS"
fi

current_memory_usage=$(free / | awk '/Mem:/ {printf "%.0f", ($3/$2)*100}')
if [[ $current_memory_usage -ge $Threshold ]]
then
	echo "Memory: FAIL ($current_memory_usage%)"
	health_check=1
else
	echo "Memory : PASS ($current_memory_usage%)"
fi

current_cpu_usage=$(top -bn1 | awk '/Cpu\(s\)/ {print 100 - $8}' | cut -d. -f1)

if [[ $current_cpu_usage -ge $Threshold ]]
then
    echo "CPU: FAIL ($current_cpu_usage%)"
    health_check=1
else
    echo "CPU: PASS ($current_cpu_usage%)"
fi

if systemctl is-active --quiet ssh
then
    echo "SSH Service: PASS"
else
    echo "SSH Service: FAIL"
    health_check=1
fi

if [[ $health_status -eq 0 ]]
then
    echo "Overall Health: PASS"
    exit 0
else
    echo "Overall Health: FAIL"
    exit 1
fi

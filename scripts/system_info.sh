#!/bin/bash
echo "==================================="
echo "  DEVFORGE SYSTEM INFORMATION  "
echo "==================================="

echo "Hostname:"
hostname

echo "System Uptime:"
uptime

echo "Running processes:"
ps aux

echo "Disk Usage:"
df -h

echo "Memory:"
free -h

echo "OS version:"
grep PRETTY_NAME /etc/os-release

echo "CPU usage:"
top -bn1 | grep "Cpu(s)"

echo "===================================="

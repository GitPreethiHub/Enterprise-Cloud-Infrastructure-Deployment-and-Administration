#!/bin/bash

echo "========================================="
echo "      SERVER HEALTH CHECK REPORT"
echo "========================================="

echo ""
echo "Date & Time:"
date

echo ""
echo "Hostname:"
hostname

echo ""
echo "Current User:"
whoami

echo ""
echo "System Uptime:"
uptime

echo ""
echo "Operating System:"
cat /etc/os-release | grep PRETTY_NAME

echo ""
echo "Kernel Version:"
uname -r

echo ""
echo "Memory Usage:"
free -h

echo ""
echo "Disk Usage:"
df -h

echo ""
echo "Mounted Block Devices:"
lsblk

echo ""
echo "Apache HTTP Server Status:"
systemctl status httpd --no-pager

echo ""
echo "Running Services:"
systemctl --type=service --state=running | head -20

echo ""
echo "Network Interfaces:"
ip addr

echo ""
echo "Listening Ports:"
ss -tuln

echo ""
echo "Public IP Address:"
curl -s ifconfig.me

echo ""
echo "========================================="
echo " Health Check Completed Successfully"
echo "========================================="
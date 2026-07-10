#!/usr/bin/env python3

import socket
import shutil
import subprocess
from datetime import datetime


def get_uptime():
    try:
        uptime = subprocess.check_output(["uptime", "-p"]).decode().strip()
        return uptime.replace("up ", "")
    except:
        return "Unavailable"


hostname = socket.gethostname()

disk = shutil.disk_usage("/")

used = round(disk.used / (1024**3))
free = round(disk.free / (1024**3))

print("=" * 55)
print("Enterprise Infrastructure Health Report")
print("=" * 55)

print(f"Date       : {datetime.now()}")
print(f"Hostname   : {hostname}")
print(f"Uptime     : {get_uptime()}")
print(f"Disk Used  : {used} GB")
print(f"Disk Free  : {free} GB")

print("=" * 55)
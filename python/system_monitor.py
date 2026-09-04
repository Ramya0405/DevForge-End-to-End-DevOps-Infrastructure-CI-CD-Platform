#!/usr/bin/env python3
import os
import shutil
import subprocess
print("======DevForge System Monitor======")
#system information
hostname = os.uname().nodename
current_user = os.getlogin()

print(f"Hostname: {hostname}")
print(f"Current_User:{current_user}")
#CPU
cpu_count = os.cpu_count()
print(f"CPU cores:{cpu_count}")

#Memory
# Memory
with open("/proc/meminfo", "r") as file:
    memory_info = file.readlines()

for line in memory_info:
    if line.startswith("MemTotal"):
        total_memory = line.split()[1]
        print(f"Memory   : {int(total_memory) // 1024} MB")
        break

# Disk
disk = shutil.disk_usage("/")

total_disk = disk.total // (1024 ** 3)
used_disk = disk.used // (1024 ** 3)
free_disk = disk.free // (1024 ** 3)

print(f"Disk Total: {total_disk} GB")
print(f"Disk Used : {used_disk} GB")
print(f"Disk Free : {free_disk} GB")

# System uptime
uptime = subprocess.run(
    ["uptime", "-p"],
    capture_output=True,
    text=True
)

print(f"Uptime      : {uptime.stdout.strip()}")

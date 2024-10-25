#!/usr/bin/python3
import subprocess
import re
import os

TOTAL_SIZE = 409599999
THREADS = 8
PARTITION = "/dev/sdb2"
processes = []
pattern = r"Interrupted at block (\d+)"

print("Executing ...")
for i in range(THREADS):
    LOG = f"/home/ronnas/badsectors/log_{i}.txt"
    SEGMENT_SIZE = TOTAL_SIZE / THREADS
    START_BLOCK = int(i * SEGMENT_SIZE)
    END_BLOCK = int((i + 1) * SEGMENT_SIZE) - (1 if i != THREADS - 1 else 0)
    if os.path.exists(LOG):
      with open(LOG) as file:
        data = file.read()
        match = re.search(pattern, data)
        if match:
           block_number = int(match.group(1))
           START_BLOCK = max(START_BLOCK,block_number)
    
    # Start the command and append the process to the list
    cmd = f"sudo badblocks -s -v {PARTITION} {END_BLOCK} {START_BLOCK} > /home/ronnas/badsectors/badsectors_{i}.txt 2> {LOG}"
    print(cmd)
    process = subprocess.Popen(cmd, shell=True)
    processes.append(process)

# Wait for all processes to complete
for process in processes:
    process.wait()
subprocess.Popen(['notify-send', "badblocks scan finished"])
for i in range(THREADS):
  with open(f"/home/ronnas/badsectors/badsectors_{i}.txt") as file:
    data = file.read()
    if data:
      subprocess.Popen(['notify-send', f"badblocks: badsectors /home/ronnas/badsectors/badsectors_{i}.txt"])

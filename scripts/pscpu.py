#!/usr/bin/python3
from  subprocess import run
result = run(
    ["ps", "-eo", "pcpu,pid,user,args", "--sort=-pcpu"],
    capture_output=True,
    text=True,
    check=True,
)
cpuResult = run(
    "vmstat 1 2 | tail -1 | awk '{print $15}'",
    capture_output=True,
    text=True,
    check=True,
    shell=True,
)
cpuValue = 100 - float(cpuResult.stdout.strip())
memo = {}
memo2 = {}
total = 0.0
for line in result.stdout.split("\n")[1:]:
    arr = list(filter(lambda x: x != "", line.strip().split(" ")))
    if len(arr) < 3 or "pcpu,pid,user,args" in line or "pscpu" in line:
        continue
    value = float(arr[0])
    memo2[arr[3]] = memo2.get(arr[3], 0) + 1
    if value > 0:
        total += value
        memo[arr[3]] = memo.get(arr[3], 0) + value
        
sortedMemo = sorted(memo.items(), key=lambda x: x[1])
for key, value in sortedMemo:
    print(
        f"{cpuValue*value/total:06.2f} % - {100*value/total:06.2f} % \t    {key.split("/")[-1]} ({memo2[key]})"
    )
print("-------------------")
print(f"{cpuValue:06.2f} % - {100.0:06.2f} %")
print("===================")

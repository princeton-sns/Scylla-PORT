#!/bin/bash

source ./parameters.bash

file="1523953294"
system="Scylla-original"
thread="32"
workload="workloada"

clients=$(cat ${client_nodes})
result=""
for client in ${clients}; do
    ssh_output=$(ssh ${client} -o StrictHostKeyChecking=no " \
        cat /local/scylladb/experiments/${file}/${system}/trial-1/${workload}+keysperop_5+threads_${thread}.data \
        | grep READ | grep AverageLatency \
    ")
    echo $ssh_output >> latency
done
all_latency=$(cat latency | awk '{print $3}' | awk -F"." '{print $1}' | awk '{s+=$1} END {print s}')
#echo $all_latency
latency=$((all_latency / 8))
echo "$system : $thread : $latency" 
rm latency

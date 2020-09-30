#!/bin/bash

source ../parameters.bash

#--- global variables, change these accordingly ---
file="1523953294"
system="Scylla-original"
num_clients=8
# -----------------

clients=$(cat ${client_nodes})
result=""
for client in ${clients}; do
    ssh_output=$(ssh ${client} -o StrictHostKeyChecking=no " \
        cat ${data_dir}/${file}/${system}/trial-1/${workload}+keysperop_${keysperop}+threads_${threads}.data \
        | grep READ | grep AverageLatency \
    ")
    echo $ssh_output >> latency
done
all_latency=$(cat latency | awk '{print $3}' | awk -F"." '{print $1}' | awk '{s+=$1} END {print s}')
#echo $all_latency
latency=$((all_latency / ${num_clients}))
echo "$system : $threads : $latency" 
rm latency

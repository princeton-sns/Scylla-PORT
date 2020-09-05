#!/bin/bash

source ../parameters.bash

file="1584075001"
system="Scylla-original"
thread="2"
workload="workloadb"
keysperop="5"

clients=$(cat ${client_nodes})
result=""
for client in ${clients}; do
    ssh_output=$(ssh ${client} -o StrictHostKeyChecking=no " \
        cat /local/scylladb/experiments/${file}/${system}/trial-1/${workload}+keysperop_${keysperop}+threads_${thread}.data \
        | grep OVERALL | grep Throughput \
    ")
    echo $ssh_output >> throughput
done
thruput=$(cat throughput | awk '{print $3}' | awk -F"." '{print $1}' | awk '{s+=$1} END {print s}')
echo "$system : $thread : $thruput" 
rm throughput

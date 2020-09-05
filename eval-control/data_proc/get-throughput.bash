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
        | grep OVERALL | grep Throughput \
    ")
    echo $ssh_output >> throughput
done
thruput=$(cat throughput | awk '{print $3}' | awk -F"." '{print $1}' | awk '{s+=$1} END {print s}')
echo "$system : $thread : $thruput" 
rm throughput

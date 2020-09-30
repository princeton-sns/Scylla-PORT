#!/bin/bash

source ../parameters.bash

# --- change these variables accordingly ---
file="1523953294"
system="Scylla-original"
# ------------------

clients=$(cat ${client_nodes})
result=""
for client in ${clients}; do
    ssh_output=$(ssh ${client} -o StrictHostKeyChecking=no " \
        cat ${data_dir}/${file}/${system}/trial-1/${workload}+keysperop_${keysperop}+threads_${threads}.data \
        | grep OVERALL | grep Throughput \
    ")
    echo $ssh_output >> throughput
done
thruput=$(cat throughput | awk '{print $3}' | awk -F"." '{print $1}' | awk '{s+=$1} END {print s}')
echo "$system : $threads : $thruput" 
rm throughput

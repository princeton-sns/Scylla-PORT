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
    ")
    echo "-------client ${client}----------" >> data_${system}_${thread}_${workload}.txt
    echo $ssh_output >> data_${system}_${thread}_${workload}.txt
    echo "---------------------------------" >> data_${system}_${thread}_${workload}.txt
done

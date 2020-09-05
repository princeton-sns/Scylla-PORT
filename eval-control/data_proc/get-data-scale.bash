#!/bin/bash

source ../parameters.bash

node=16
file="1555489233"
system="Scylla-moon"
thread="32"
workload="workloadb"

clients=$(cat ${client_nodes})
result=""
for client in ${clients}; do
    ssh_output=$(ssh ${client} -o StrictHostKeyChecking=no " \
        cat /local/scylladb/experiments/${file}/${system}/trial-1/${workload}+keysperop_5+threads_${thread}.data \
    ")
    echo "-------client ${client}----------" >> data_Scylla-original_scalability_${node}node.txt
    echo $ssh_output >> data_Scylla-original_scalability_${node}node.txt
    echo "---------------------------------" >> data_Scylla-original_scalability_${node}node.txt
done

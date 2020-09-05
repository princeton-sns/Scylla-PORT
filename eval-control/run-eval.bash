#!/bin/bash

### the highest level of script that controls the eval ###

source ./parameters.bash # port all parameters

source ${control_dir}/init.bash # initialize all nodes, e.g., create scylla.yaml

source ./eval-commands.bash

exp_uid=$(date +%s)
echo "Running experiment ID: ${exp_uid}"
## now start running experiments ##
# in each trial, eval order is: Scylla-original -> Scylla-moon -> Scylla-2rounds
# for each system, do the following in order:
#       compile ycsb client
#       launch servers
#       ycsb-load
#       ycsb-run
for trial in $(seq ${trials}); do
#    for system in Scylla-original Scylla-moon Scylla-occ; do
    for system in Scylla-moon; do
#    for system in Scylla-original; do
#    for system in Scylla-occ; do
	clean-up
	./kill-control.bash
sleep 10
        compile-ycsb ${system}
sleep 10
        launch-servers ${system}
sleep 10
        ycsb-load ${system}
sleep 10
        ycsb-run ${system} ${exp_uid} ${trial}
sleep 10
        clean-up
 	./kill-control.bash
    done
done

#!/bin/bash

### the highest level of script that controls the eval ###

source ./parameters.bash # port all parameters

#source ${control_dir}/init.bash # initialize all nodes, e.g., create scylla.yaml

source ./eval-commands.bash

exp_uid=$(date +%s)
## now start running experiments ##
# in each trial, eval order is: Scylla-original -> Scylla-moon -> Scylla-2rounds
# for each system, do the following in order:
#       compile ycsb client
#       launch servers
#       ycsb-load
#       ycsb-run
for trial in $(seq ${trials}); do
#    for system in Scylla-original Scylla-moon Scylla-2rounds; do
    for system in Scylla-original; do
#    for system in Scylla-moon; do	
#     for system in Scylla-2rounds; do
#        compile-ycsb ${system}
#        launch-servers ${system}
#        ycsb-load ${system}
#        ycsb-run ${system} ${exp_uid} ${trial}
        clean-up
 	./kill-control.bash
    done
done

#!/bin/bash

### put all experiment parameters here ###

### layout setup related ###
# for each server node #
user="$USER"
group="cops"
local_dir="/local"  # we assume the repo is cloned to /local, if not, e.g., /foo, then change this to "/foo"
scylla_dir="${local_dir}/Scylla-PORT"
conf_dir="${scylla_dir}/conf"
scripts_dir="${scylla_dir}/scripts"
var_dir="${scylla_dir}/scylla_var"
scylla_original="${scylla_dir}/Scylla-original"
scylla_original_ycsb="${scylla_original}/ycsb_benchmark"
scylla_moon="${scylla_dir}/Scylla-moon"
scylla_moon_ycsb="${scylla_moon}/ycsb-moon"
scylla_2rounds_ycsb="${scylla_moon}/ycsb-2rounds"
scylla_occ_ycsb="${scylla_original}/ycsb_occ"
data_dir="${scylla_dir}/experiments"

# for control node #
control_dir="${scylla_dir}/eval-control"    # this is only for the control node
servers_file="server-node.txt"
clients_file="client-node.txt"
server_nodes="${control_dir}/${servers_file}"
client_nodes="${control_dir}/${clients_file}"
ycsb_killer="${control_dir}/kill-ycsb.bash"
scylla_killer="${control_dir}/kill-scylla.bash"

### experiment parameters ###
trials=1
keysperop=5
recordcount=1000000
operationcount=50000
threads=32
workload=workloadb
run_time=1400

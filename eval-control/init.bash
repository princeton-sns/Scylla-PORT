#!/bin/bash

### prepare scylla.yaml from base for each server node ###
source ./parameters.bash    # load parameters
servers=$(cat ${server_nodes})
seeds=$(echo ${servers} | sed 's/ /, /g')

for server in ${servers}; do
    # prepare scylla.yaml
    sed 's/ADDR/'${server}'/g' ${control_dir}/scylla-BASE.yaml \
            | sed 's/SEEDS/'"$seeds"'/g' \
            > ${control_dir}/scylla.yaml
    # send to server
    scp ${control_dir}/scylla.yaml $server:${conf_dir}/
done
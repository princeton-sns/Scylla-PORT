#!/bin/bash

### commands for running scylla eval ###
source ./parameters.bash

compile-ycsb() { # compile ycsb clients when switching systems
    system=$1
    ycsb=""
    echo "Compiling YCSB for ${system} . . ."
    if [ ${system} == "Scylla-original" ]; then
        # use right .m2 repo. We should have a better solution for this
        # e.g., create a new db for scylla-moon on ycsb instead of modifying
        # cassandra-10. It is okay for now
	rm -f -R ~/.m2/
#        cp -R ~/M2-ORIGINAL/ ~/.m2/
#	cp -R /proj/cops/haonan/Scylla-YCSB-M2/m2-ORIGINAL/ ~/.m2/
	cp -R ${control_dir}/m2-ORIGINAL/ ~/.m2/
        ycsb=${scylla_original_ycsb}
    elif [ ${system} == "Scylla-occ" ]; then
        # use right .m2 repo. We should have a better solution for this
        # e.g., create a new db for scylla-moon on ycsb instead of modifying
        # cassandra-10. It is okay for now
        rm -f -R ~/.m2/
#	cp -R /proj/cops/haonan/Scylla-YCSB-M2/m2-ORIGINAL/ ~/.m2/
#        cp -R ~/M2-ORIGINAL/ ~/.m2/
	cp -R ${control_dir}/m2-ORIGINAL/ ~/.m2/
        ycsb=${scylla_occ_ycsb}
    elif [ ${system} == "Scylla-moon" ]; then
	rm -f -R ~/.m2/
#        cp -R /proj/cops/haonan/Scylla-YCSB-M2/m2-MOON/ ~/.m2/
	cp -R ${control_dir}/m2-MOON/ ~/.m2/
        ycsb=${scylla_moon_ycsb}
    elif [ ${system} == "Scylla-2rounds" ]; then
        ycsb=${scylla_2rounds_ycsb}
    else
        echo "FATAL in compiling ycsb! System not recoganized. Should be Scylla-original or Scylla-moon or Scylla-2rounds"
    fi
    sleep 3     # for file system to propagate
    clients=$(cat ${client_nodes})
    
    echo " ... copying .m2 to all client nodes"
    for client in ${clients}; do 
        scp -r ~/.m2 ${client}:"$HOME" 
    done

    echo " ... now running mvn to compile ycsb on each client"
    for client in ${clients}; do
        # compile ycsb on each client
        ssh -o StrictHostKeyChecking=no ${client} " \
            cd ${ycsb}; \
            mvn -Dcheckstyle.console=false -Dcheckstyle.skip -pl com.yahoo.ycsb:cassandra-binding -am clean package \
        "
    done
    sleep 5     # let ycsb take a rest
    echo "Compiling YCSB for ${system} . . . DONE"
}

launch-servers() { # launch servers for each system
    system=$1
    src_dir=""
    echo "Launching servers for ${system} . . ."
    if [ ${system} == "Scylla-original" ]; then
        src_dir=${scylla_original}
    elif [ ${system} == "Scylla-occ" ]; then
        src_dir=${scylla_original}
    elif [ ${system} == "Scylla-moon" ]; then
        src_dir=${scylla_moon}
    elif [ ${system} == "Scylla-2rounds" ]; then
        src_dir=${scylla_moon}
    else
        echo "FATAL in launching servers! System not recoganized. Should be Scylla-original or Scylla-moon or Scylla-2rounds"
    fi
    servers=$(cat ${server_nodes})
    for server in ${servers}; do
        (while [ 1 ]; do
            # launch system on each server machine
#           ssh -o StrictHostKeyChecking=no ${server} " \
            ssh_output=$(ssh -o StrictHostKeyChecking=no ${server} " \
                rm -rf ${var_dir}; \
		mkdir -p ${var_dir}; \
                cd ${src_dir}; \
                ./build/release/scylla --max-io-requests=256 --options-file ${conf_dir}/scylla.yaml --enable-cache=0 > ${var_dir}/launch_server_log.txt")
#           ./build/release/scylla --max-io-requests=256 --options-file ${conf_dir}/scylla.yaml --enable-cache=0 > ${var_dir}/launch_server_log.txt"
            failure=$(echo ${ssh_output} | grep "error")
            if [ "${failure}" == "" ]; then
                echo ${server}": LAUNCHED"
	            break
	        fi
	    done) &
    done
    sleep 10 # wait for servers to sync

    # now check cluster status
    timeout=20
    normal_nodes=0
    echo "Nodes up and normal: "
    wait_time=0
    total_nodes=$(echo ${servers} | wc -w)
    leader_node=$(echo ${servers} | awk -F" " '{print $1}')
    while [ "${normal_nodes}" -ne "${total_nodes}" ]; do
        sleep 5
        normal_nodes=$(ssh -o StrictHostKeyChecking=no ${leader_node} " \
            sudo systemctl start scylla-jmx; \
	        nodetool status 2>&1 | grep UN | wc -l")
        echo "Number of normal nodes: "${normal_nodes}
	    wait_time=$((wait_time+5))
	    if [[ ${wait_time} -ge ${timeout} ]]; then
	        echo "timeout waiting for nodes to come up ... you'll need to try again"
	        exit 1
	    fi
    done
    sleep 5
    # now populate keyspace
    echo "Populate KeySpace: usertable"
    cqlsh ${leader_node} < ${control_dir}/create_YCSB_table_thrift_nondurable.cql
    sleep 5
    echo "Launching servers for ${system} . . . DONE"
}

ycsb-load() { # YCSB load phase
sleep 10
    system=$1
    src_dir=""
    echo "YCSB-LOAD . . ."
    if [ ${system} == "Scylla-original" ]; then
        src_dir=${scylla_original_ycsb}
    elif [ ${system} == "Scylla-occ" ]; then
        src_dir=${scylla_occ_ycsb}
    elif [ ${system} == "Scylla-moon" ]; then
        src_dir=${scylla_moon_ycsb}
    elif [ ${system} == "Scylla-2rounds" ]; then
        src_dir=${scylla_2rounds_ycsb}
    else
        echo "FATAL in YCSB-LOAD! System not recoganized. Should be Scylla-original or Scylla-moon or Scylla-2rounds"
    fi
    clients=$(cat ${client_nodes})
    servers=$(cat ${server_nodes})
    servers_ycsb=$(echo ${servers} | sed 's/ /,/g')
    leader_node=$(echo ${clients} | awk -F" " '{print $1}')
    # for now, we use one client for loading phase.
    # if expt is too big in terms of recordcount, we need to partition the load to all clients
    load_attempts=0
    MAX_ATTEMPTS=10
    while [ 1 ]; do
        (sleep 6000; killall ssh) &
	    killall_ssh_pid=$!

        ssh ${leader_node} -t -t -o StrictHostKeyChecking=no " \
            cd ${src_dir}; \
            ./bin/ycsb load cassandra-10 -p hosts=${servers_ycsb}  -P workloads/${workload} -threads ${threads} -p recordcount=${recordcount} -s \
        " 2>&1 | awk '{ print "'$client': "$0 }' &
        pop_pid=$!
        #wait for clients to finish
	    wait $pop_pid
	    sleep 1
	    kill ${killall_ssh_pid}
	    killed_killall=$?
	    if [ ${killed_killall} == "0" ]; then
	        break;
	    fi
	    ((load_attempts++))
	    if [[ ${load_attempts} -ge ${MAX_ATTEMPTS} ]]; then
	        echo "FAILED. Could not load the cluster after ${MAX_ATTEMPTS} attempts"
	        exit;
	    fi
	    echo "Load failed ${load_attempts} times, trying again (out of ${MAX_ATTEMPTS})"
	done
#	sleep 45
	sleep 1
	echo "YCSB-LOAD . . . DONE"
}

ycsb-run() { # run ycsb transaction phase
	system=$1
    exp_uid=$2
    trial=$3
    src_dir=""
    exp_dir="${data_dir}/${exp_uid}/${system}/trial-${trial}"
    data_file="${workload}+keysperop_${keysperop}+threads_${threads}.data"
    output_noise="DBWrapper: report latency for each error is false and specific error codes to track for latency are: []"
    echo "YCSB-RUN . . ."
    if [ ${system} == "Scylla-original" ]; then
        src_dir=${scylla_original_ycsb}
    elif [ ${system} == "Scylla-occ" ]; then
        src_dir=${scylla_occ_ycsb}
    elif [ ${system} == "Scylla-moon" ]; then
        src_dir=${scylla_moon_ycsb}
    elif [ ${system} == "Scylla-2rounds" ]; then
        src_dir=${scylla_2rounds_ycsb}
    else
        echo "FATAL in YCSB-RUN! System not recoganized. Should be Scylla-original or Scylla-moon or Scylla-2rounds"
    fi

    # now launch experiments on each client
    clients=$(cat ${client_nodes})
    servers=$(cat ${server_nodes})
    servers_ycsb=$(echo ${servers} | sed 's/ /,/g')
    clients_ycsb=$(echo ${clients} | sed 's/ /,/g')
    for client in ${clients}; do
        ssh ${client} -o StrictHostKeyChecking=no " \
            mkdir -p ${exp_dir}; \
            cd ${src_dir}; \
            ((./bin/ycsb run cassandra-10 -p hosts=${servers_ycsb}  -P workloads/${workload} -threads ${threads} -p operationcount=${operationcount} -p keysperop=${keysperop}  -s \
            > >(tee ${exp_dir}/${data_file}) \
	    2> ${exp_dir}/${data_file}.stderr \
            ) &); \
            sleep $((run_time + 10)); ${ycsb_killer} \
        " 2>&1 | awk '{ print "'${client}': "$0 }' &
    done
    #wait for clients to finish
	wait
	echo "YCSB-RUN . . . DONE"
}

clean-up() {
    servers=$(cat ${server_nodes})
    clients=$(cat ${client_nodes})
    # kill scylla instances on servers
    for server in ${servers}; do
        ssh -o StrictHostKeyChecking=no ${server} " \
            ${scylla_killer}; \
        "
    done
    # kill ycsb instances
    for client in ${clients}; do
        ssh -o StrictHostKeyChecking=no ${client} " \
            ${ycsb_killer}; \
        "
    done
}

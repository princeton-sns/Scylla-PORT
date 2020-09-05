# Scylla-PORT
## 1. Background
Scylla-PORT implements performance-optimal read-only transactions on top of ScyllaDB. Being performance-optimal, read-only transactions require only one-round of messsages between the client and servers, are non-blocking, e.g., no distributed locks for concurrency control, and each transaction request only requires a constant amount of metadata for processing. The base system ScyllaDB does not support transactions but only has simple operations. Scylla-PORT implements performance-optimal read-only transactions that work together with simple writes. For details, please see our paper published in OSDI '20.

## 2. System Requirements
We highly recommend re-creating the experimental environment close to the settings explained in the paper, which include the following specifications:

2.1 Machine type: Emulab d430 nodes (two 2.4GHz 8-Core Xeon CPUs, 64GB RAM, and a 10 Gbps network interface).

2.2 Operating System: Ubuntu 16.04 STD. (Please note that current system only works with Ubuntu)

## 3. Build
3.1 Clone this repository onto a machine. We suggest using an empty directory. The scripts in the package will work seamlessly if the repo is cloned into "/local".

    xxx:/local$ git clone https://github.com/princeton-sns/Scylla-PORT.git    
   
   The above command will clone this repo into /local with a new repo directory named "Scylla-PORT". Run the following command to set ownership:
   
    xxx:/local$ username="$USER"; sudo chown -R ${username}:cops /local/

3.2 Install dependencies by running 

    xxx:/local/Scylla-PORT/Scylla-moon$ sudo ./install-ubuntu-dependencies.bash
    
  If the repository has to be cloned to somewhere different from /local, then please see 6.1 below.
        
  If the dependency installation fails the first time, please run the above command again. The failure (relatively common) is mostly due to the asynchrony of downloading dependencies. It should succeed within 3 attempts. In later attempts, we might encounter prompts as below, we can choose [A]ll
  
    replace ninja-1.8.2/.clang-format? [y]es, [n]o, [A]ll, [N]one, [r]ename:
  
  Run the following command to hard set the number of file descriptors (Important: ScyllaDB will not run if nfile is low):
  
    xxx:/local/Scylla-PORT$ sudo ./inc_fd_num.sh      

3.3 Build the source code. There are two pieces of source code in the repo. One is in the Scylla-PORT/Scylla-moon subdirectory, which is the source code for Scylla-PORT; the other is in the Scylla-PORT/Scylla-original subdirectory, which is the source code for the baseline system Scylla-PORT. We need to build both. Scylla-original also contains the OCC implementation atop ScyllaDB. Due to legacy issues, Scylla-moon means Scylla-PORT. 
   
   Build Scylla-moon: 
   
    xxx:/local/Scylla-PORT/Scylla-moon$ ./configure.py --mode=release --cflags='-I/opt/scylladb/include -L/opt/scylladb/lib64' --compiler=/opt/scylladb/bin/g++-7  (config)
   
    xxx:/local/Scylla-PORT/Scylla-moon$ ninja -j16 (build. 16 is the number of cores)
   
   Build Scylla-original:      
   
    xxx:/local/Scylla-PORT/Scylla-original$ ./configure.py --mode=release --cflags='-I/opt/scylladb/include -L/opt/scylladb/lib64' --compiler=/opt/scylladb/bin/g++-7  (config)
                     
    xxx:/local/Scylla-PORT/Scylla-original$ ninja -j16 (build. 16 is the number of cores)         
   
 The build may take a while. Note: if the config step, i.e., the one calling ./configure.py, fails, then it means dependencies were not installed successfully. Please go back to step 3.2 and run install-ubuntu-dependencies.bash again.
 
 After the build is done, we need to modify the file: /lib/systemd/system/scylla-jmx.service by commenting out:  
 
    Requires=scylla-server.service
    After=scylla-server.service
	
  And then modify "User=scylla" to your username and modify "Group=scylla" to "Group=cops". Then run the following two commands:
  
    sudo systemctl daemon-reload
    sudo systemctl start scylla-jmx
   
3.4 Build on a cluster of nodes: please repeat the steps 3.1 to 3.3 on all the machines Scylla-PORT will be run on. An easier option is to make an image that contains a built Scylla-PORT system (e.g., after done 3.3) and start all the other machines by loading the image (Cloud platforms like Emulab and Azure normally have this image creation functionality). Another option is to use scp to copy everything in the /local directory to the /local directory on the other nodes (need to install dependencies on other nodes first, e.g., step 3.2. Due to the large size of the system, scp may take a while).

## 4. Run Experiments

To run experiments, we only need to work on the control node, e.g., ip0. That is, from now on, we should not have to touch any other nodes in the clusters. 
Now let us log onto the control node for the rest of this document, e.g., via ssh ip0, assuming ip0 is the ip/alias of the control node.

#### All the scripts used to run Scylla-PORT experiments are in xxx:/local/Scylla-PORT/eval-control/

4.1 Set up clusters. 

Suppose we want to set up a single cluster with 8 servers and 8 clients as described in the paper. Then, we need 17 machinies totally: 16 for client and servers and 1 extra for the control node.

Modify the following two files to setup the clusters: 

    xxx:/local/Scylla-PORT/eval-control/server-node.txt and xxx:/local/Scylla-PORT/eval-control/client-node.txt
                    
server-node.txt is the file that contains all the ssh'able name of the server machines, e.g., ip address or alias. client-node.txt contains the names of client machines. For example, to create a 2-server-2-client environment, then we need 5 machines totally. Say their ip addresses are ip0, ip1, ..., ip4. Then we need to make server-node.txt:

    ip1

    ip2

And make client-node.txt be:

    ip3

    ip4

This setup means node ip1 and ip2 are used as servers while ip3 and ip4 are clients. All nodes are in the same cluster.

This package has included the sample files for an 8-server-8-client environment (may need to update the ips/alias to match your machines).

4.2 Experiment parameters. The parameters, e.g., number of keys, value sizes, are specified in: 
    
    xxx:/local/Scylla-PORT/eval-control/parameters.bash

Note: we do not have to modify those parameters before running an experiment.

4.3 Run an experiment. Use the following command to run the script file

    xxx:/local/Scylla-PORT/eval-control$ ./run-eval.bash
    
This script will run a single trial experiment of Scylla-moon with the default parameters specified in parameters.bash. In run-eval.bash, lines 22 -- 24 control which system to run. It has three options: Scylla-moon, Scylla-original, and Scylla-occ.

## 5. Understand the Results
Each experiment will be given a unique name generated via system time, e.g., "1599241223". All experiment results are stored on each client machine: 

    xxx:/local/Scylla-PORT/experiments/

A set of scripts for data processing are provided in:

    xxx:/local/Scylla-PORT/eval-control/data_proc
    
## 6. Other Notes
6.1 If the repository has to be cloned to a place different from /local/, e.g., /foo/, then the variable "local_dir" needs to be updated accordingly in the following file:

    /foo/Scylla-PORT/eval-control/parameters.bash
    
6.2 When the experiment is running, detailed logs are output to the screen, e.g., 

    Nodes up and normal: 
    Number of normal nodes:  X
    
X should be 8 if running an 8-server-8-client experiment. 

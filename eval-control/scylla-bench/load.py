import time
import os
import sys
import ConfigParser
import threading

config = ConfigParser.RawConfigParser()
config = ConfigParser.ConfigParser()
configPath=os.getcwd()
config.read(configPath + '/config.cfg')

SCYLLA_OPS_STARTING = int(config.get('scylla','ops_starting'))
SCYLLA_OPS_INTERVAL = int(config.get('scylla','ops_interval'))
SCYLLA_MAX_OPS = int(config.get('scylla','max_ops'))
SCYLLA_SEED = config.get('scylla','seed')

CASSANDRA_OPS_STARTING = int(config.get('cassandra','ops_starting'))
CASSANDRA_OPS_INTERVAL = int(config.get('cassandra','ops_interval'))
CASSANDRA_MAX_OPS = int(config.get('cassandra','max_ops'))
CASSANDRA_SEED = config.get('cassandra','seed')

YCSB_MACHINES = int(config.get('ycsb','num_machines'))
YCSB_LOADERS_PER_MACHINE = int(config.get('ycsb','loader_per_machine'))
YCSB_RUN_TIME =int(config.get('ycsb','run_time_in_min'))
YCSB_THREADS = int(config.get('ycsb','threads'))
YCSB_TABLE_RECORDS = int(config.get('ycsb','table_record_count'))
YCSB_INSTANCES = YCSB_LOADERS_PER_MACHINE * YCSB_MACHINES


def prepare_cmd(db_type,ycsb_ops, ycsb_ops_count, seed_node, ops,ycsb_machine_id):
    cmd = 'ansible  -i hosts.ini ycsb  -u root -m shell -a \'/root/ycsb-0.5.0/bin/ycsb run cassandra2-cql -p hosts="'+seed_node+'" -P /root/ycsb-0.5.0/workloads/workloada  -p operationcount='+str(ycsb_ops_count)+'  -p cassandra.writeconsistencylevel=QUORUM -p cassandcra.readconsistencylevel=QUORUM -threads '+str(YCSB_THREADS)+' -target '+str(ycsb_ops)+' -s 2>> stat_'+str(ops/1000)+'k.log\' -vv | tee /root/'+db_type+'/'+str(ops/1000)+'k_'+str(ycsb_machine_id).zfill(2)+'_OPS.log'
    return cmd

def reset_scylla_db():
    cmd="ansible  -i hosts.ini scylla  -u root -m shell -a 'systemctl stop scylla-server'"
    os.system(cmd)
    cmd="ansible  -i hosts.ini scylla  -u root -m shell -a 'rm -rf /var/lib/scylla/*'"
    os.system(cmd)
    cmd="ansible  -i hosts.ini scylla  -u root -m shell -a 'systemctl start scylla-server'"
    os.system(cmd)
    cmd="ansible  -i hosts.ini scylla  -u root -m shell -a 'systemctl start scylla-jmx'"
    os.system(cmd)
    print "waiting 20 seconds for cluster to be ready ..."
    time.sleep(20)

def reset_cassandra_db():
    cmd="ansible -i hosts.ini cassandra  -u root -m shell -a 'service cassandra stop'"
    os.system(cmd)
    cmd="ansible -i hosts.ini cassandra  -u root -m shell -a 'pkill -9 java'"
    os.system(cmd)
    # To free pagecache
    cmd="ansible -i hosts.ini cassandra  -u root -m shell -a 'echo 1 > /proc/sys/vm/drop_caches'"
    os.system(cmd)
    cmd="ansible -i hosts.ini cassandra  -u root -m shell -a 'rm -rf /var/lib/cassandra/*'"
    os.system(cmd)
    cmd="ansible -i hosts.ini cassandra  -u root -m shell -a 'chown -R cassandra:cassandra /var/lib/cassandra/'"
    os.system(cmd)
    cmd="ansible -i hosts.ini cassandra  -u root -m shell -a 'service cassandra start'"
    os.system(cmd)
    print "waiting 20  seconds for cluster to be ready ..."
    time.sleep(20)

def perpare_data(seed_node):
    print "Creating YCSB table ..."
    cmd = 'cqlsh '+seed_node + ' < create_YCSB_table.cql'
    os.system(cmd)
    cmd='/root/ycsb-0.5.0/bin/ycsb load cassandra2-cql -p hosts="'+seed_node+'" -P /root/ycsb-0.5.0/workloads/workloada  -p recordcount='+str(YCSB_TABLE_RECORDS)+'  -threads 1000 -s'
    os.system(cmd)

def run_cmd(cmd):
    os.system(cmd)
    
def run_load(db_type, ops_start, ops_interval, max_ops,seed):
    print db_type + " ops start = " + str(SCYLLA_OPS_STARTING)
    ops = ops_start
    print "ops are " + str(ops)
    while (ops <= max_ops):
        ycsb_ops = ops / YCSB_INSTANCES
        print "ycsb ops = " +str(ycsb_ops)
        ycsb_ops_count = ycsb_ops * YCSB_RUN_TIME * 60

        if db_type=='scylla':
            reset_scylla_db()
            perpare_data(SCYLLA_SEED)
        elif db_type=='cassandra':
            reset_cassandra_db()
            perpare_data(CASSANDRA_SEED)

        #This should really happen within each machine but not that important in practice
        threads = []
        for i in range (0,YCSB_LOADERS_PER_MACHINE):
            cmd = prepare_cmd(db_type,ycsb_ops, ycsb_ops_count, seed, ops,i+1)
            print cmd
            t = threading.Thread(target=run_cmd,args=(cmd,))
            threads.append(t)
            t.start()
        for t in threads:
            t.join()
        time.sleep(300)
        ops = ops + ops_interval

if __name__ == "__main__":
    print "Scylla Loader "
    print "each loader run 15 minutes"
    if len(sys.argv) !=2 :
        print ("Must Enter db type : cassandra or scylla")
        exit()
    else:
        db_type=sys.argv[1]

    if (db_type=="scylla"):
        print "Running Scylla Load ..."
        if not os.path.exists('scylla'):
            os.makedirs('scylla')
        cmd="ansible  -i hosts.ini scylla  -u root -m shell -a 'systemctl stop firewalld'"
        os.system(cmd)
        cmd="ansible  -i hosts.ini ycsb  -u root -m shell -a 'rm -rf /root/*.log'"
        os.system(cmd)
        run_load(db_type,SCYLLA_OPS_STARTING,SCYLLA_OPS_INTERVAL,SCYLLA_MAX_OPS,SCYLLA_SEED)
    elif (db_type=="cassandra"):
        print "Running Cassandra Load ..."
        if not os.path.exists('cassandra'):
            os.makedirs('cassandra')
        cmd="ansible  -i hosts.ini cassandra  -u root -m shell -a 'systemctl stop firewalld'"
        os.system(cmd)
        cmd="ansible  -i hosts.ini ycsb  -u root -m shell -a 'rm -rf /root/*.log'"
        os.system(cmd)
        run_load(db_type,CASSANDRA_OPS_STARTING,CASSANDRA_OPS_INTERVAL,CASSANDRA_MAX_OPS,CASSANDRA_SEED)
    else:
        print "db type must be scylla or cassandra"

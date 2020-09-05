#!/bin/bash

for pid in $(ps x | grep "com.yahoo.ycsb.db.CassandraClient10" | awk '{ print $1 }'); do
    kill -KILL $pid
done

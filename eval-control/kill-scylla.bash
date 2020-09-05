#!/bin/bash

# kill all scylla instances
for pid in $(ps x | grep "build/release/scylla" | awk '{ print $1 }'); do
    kill -KILL $pid
done

for pid in $(ps x | grep "/usr/lib/scylla/jmx/symlinks/scylla-jmx" | awk '{ print $1 }'); do
    kill -KILL $pid
done

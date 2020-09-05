for pid in $(ps x | grep "StrictHostKeyChecking=no" | awk '{ print $1 }'); do kill -KILL $pid; done
for pid in $(ps x | grep "run-eval" | awk '{ print $1 }'); do kill -KILL $pid; done

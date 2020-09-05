package com.yahoo.ycsb.db;

import java.nio.ByteBuffer;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/*
 * ClientView stores per-client information on the most recent
 * commit time on each server (we per subset of keys, e.g., mod 1000, in Scylla-MOON)
 * ClientView takes care of updating the commit-time-to-key mapping, and compute readTS
 * based upon the mapping.
 * Operations in this class should be atomic
 */
public class ClientView {
    private final int KEY_BUCKET_SIZE = 1000; // this is size of group of keys
    private final int VERSION_CAP = 10000000; // guard version number
    // we will do key % KEY_BUCKET_SIZE, so the view will have KEY_BUCKET_SIZE elements
    private Map<Integer, Integer> view = new ConcurrentHashMap<Integer, Integer>(KEY_BUCKET_SIZE);
    private int current_version_to_read = 1;  // starts with version 1.

    public void update_view(ByteBuffer key, int most_recent_version) {
        int index = key.hashCode() % KEY_BUCKET_SIZE;
        if (view.containsKey(index) && view.get(index) >= most_recent_version) {
            return;
        }
        view.put(index, most_recent_version);
    }
    // this is called after each write
    // do not need sync for now, cuz one instance of CV per client
    public /*synchronized*/ void set_current_version_to_read(int new_ts) {
        if (new_ts == Integer.MAX_VALUE || new_ts >= VERSION_CAP) {
            return;
        }
        if (current_version_to_read < new_ts) {
            current_version_to_read = new_ts;
        }
    }

    // called by each rotxn
    public int get_version_to_read(List<ByteBuffer> keys) {
        int version_to_read = Integer.MAX_VALUE;
        int index = 0;
        for (ByteBuffer key : keys) {
            index = key.hashCode() % KEY_BUCKET_SIZE;
            if (!view.containsKey(index)) {
                return current_version_to_read;
            }
            if (view.get(index) < version_to_read) {
                version_to_read = view.get(index);
            }
        }
        set_current_version_to_read(version_to_read);
        return current_version_to_read;
    }

    // called by write
    public int get_current_read_version(boolean isLoading) {
        return isLoading ? 0 : current_version_to_read;
    }
}

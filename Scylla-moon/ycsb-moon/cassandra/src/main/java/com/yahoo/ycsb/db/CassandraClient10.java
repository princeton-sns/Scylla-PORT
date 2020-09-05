/**
 * Copyright (c) 2010 Yahoo! Inc. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you
 * may not use this file except in compliance with the License. You
 * may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * permissions and limitations under the License. See accompanying
 * LICENSE file.
 */

package com.yahoo.ycsb.db;

import com.yahoo.ycsb.*;

import org.apache.cassandra.thrift.AuthenticationRequest;
import org.apache.cassandra.thrift.Cassandra;
import org.apache.cassandra.thrift.Column;
import org.apache.cassandra.thrift.ColumnOrSuperColumn;
import org.apache.cassandra.thrift.ColumnParent;
import org.apache.cassandra.thrift.ColumnPath;
import org.apache.cassandra.thrift.ConsistencyLevel;
import org.apache.cassandra.thrift.KeyRange;
import org.apache.cassandra.thrift.KeySlice;
import org.apache.cassandra.thrift.Mutation;
import org.apache.cassandra.thrift.SlicePredicate;
import org.apache.cassandra.thrift.SliceRange;
import org.apache.thrift.protocol.TBinaryProtocol;
import org.apache.thrift.protocol.TProtocol;
import org.apache.thrift.transport.TFramedTransport;
import org.apache.thrift.transport.TSocket;
import org.apache.thrift.transport.TTransport;

import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;
import java.util.Vector;

//XXXX if we do replication, fix the consistency levels
/**
 * Cassandra 1.0.6 client for YCSB framework.
 */
public class CassandraClient10 extends DB {
  public static final int OK = 0;
  public static final int ERROR = -1;
  public static final ByteBuffer EMPTY_BYTE_BUFFER =
      ByteBuffer.wrap(new byte[0]);

  public static final String CONNECTION_RETRY_PROPERTY =
      "cassandra.connectionretries";
  public static final String CONNECTION_RETRY_PROPERTY_DEFAULT = "300";

  public static final String OPERATION_RETRY_PROPERTY =
      "cassandra.operationretries";
  public static final String OPERATION_RETRY_PROPERTY_DEFAULT = "300";

  public static final String USERNAME_PROPERTY = "cassandra.username";
  public static final String PASSWORD_PROPERTY = "cassandra.password";

  public static final String COLUMN_FAMILY_PROPERTY = "cassandra.columnfamily";
  public static final String COLUMN_FAMILY_PROPERTY_DEFAULT = "data";

  public static final String READ_CONSISTENCY_LEVEL_PROPERTY =
      "cassandra.readconsistencylevel";
  public static final String READ_CONSISTENCY_LEVEL_PROPERTY_DEFAULT = "ONE";

  public static final String WRITE_CONSISTENCY_LEVEL_PROPERTY =
      "cassandra.writeconsistencylevel";
  public static final String WRITE_CONSISTENCY_LEVEL_PROPERTY_DEFAULT = "ONE";

  public static final String SCAN_CONSISTENCY_LEVEL_PROPERTY =
      "cassandra.scanconsistencylevel";
  public static final String SCAN_CONSISTENCY_LEVEL_PROPERTY_DEFAULT = "ONE";

  public static final String DELETE_CONSISTENCY_LEVEL_PROPERTY =
      "cassandra.deleteconsistencylevel";
  public static final String DELETE_CONSISTENCY_LEVEL_PROPERTY_DEFAULT = "ONE";

  private int connectionRetries;
  private int operationRetries;
  private String columnFamily;

  private TTransport tr;
  private Cassandra.Client client;

  private boolean debug = false;

  private String tableName = "";
  private Exception errorexception = null;

  private List<Mutation> mutations = new ArrayList<Mutation>();
  private Map<String, List<Mutation>> mutationMap =
      new HashMap<String, List<Mutation>>();
  private Map<ByteBuffer, Map<String, List<Mutation>>> record =
      new HashMap<ByteBuffer, Map<String, List<Mutation>>>();

  private ColumnParent parent;

  private ConsistencyLevel readConsistencyLevel = ConsistencyLevel.ONE;
  private ConsistencyLevel writeConsistencyLevel = ConsistencyLevel.ONE;
  private ConsistencyLevel scanConsistencyLevel = ConsistencyLevel.ONE;
  private ConsistencyLevel deleteConsistencyLevel = ConsistencyLevel.ONE;

  private ClientView cv;

  /**
   * Initialize any state for this DB. Called once per DB instance; there is one
   * DB instance per client thread.
   */
  public void init() throws DBException {
    String hosts = getProperties().getProperty("hosts");
    if (hosts == null) {
      throw new DBException(
          "Required property \"hosts\" missing for CassandraClient");
    }

    columnFamily = getProperties().getProperty(COLUMN_FAMILY_PROPERTY,
        COLUMN_FAMILY_PROPERTY_DEFAULT);
    parent = new ColumnParent(columnFamily);

    connectionRetries =
        Integer.parseInt(getProperties().getProperty(CONNECTION_RETRY_PROPERTY,
            CONNECTION_RETRY_PROPERTY_DEFAULT));
    operationRetries =
        Integer.parseInt(getProperties().getProperty(OPERATION_RETRY_PROPERTY,
            OPERATION_RETRY_PROPERTY_DEFAULT));

    String username = getProperties().getProperty(USERNAME_PROPERTY);
    String password = getProperties().getProperty(PASSWORD_PROPERTY);

    readConsistencyLevel = ConsistencyLevel
        .valueOf(getProperties().getProperty(READ_CONSISTENCY_LEVEL_PROPERTY,
            READ_CONSISTENCY_LEVEL_PROPERTY_DEFAULT));
    writeConsistencyLevel = ConsistencyLevel
        .valueOf(getProperties().getProperty(WRITE_CONSISTENCY_LEVEL_PROPERTY,
            WRITE_CONSISTENCY_LEVEL_PROPERTY_DEFAULT));
    scanConsistencyLevel = ConsistencyLevel
        .valueOf(getProperties().getProperty(SCAN_CONSISTENCY_LEVEL_PROPERTY,
            SCAN_CONSISTENCY_LEVEL_PROPERTY_DEFAULT));
    deleteConsistencyLevel = ConsistencyLevel
        .valueOf(getProperties().getProperty(DELETE_CONSISTENCY_LEVEL_PROPERTY,
            DELETE_CONSISTENCY_LEVEL_PROPERTY_DEFAULT));

    debug = Boolean.parseBoolean(getProperties().getProperty("debug", "false"));

    String[] allhosts = hosts.split(",");
    String myhost = allhosts[Utils.random().nextInt(allhosts.length)];

    Exception connectexception = null;

    for (int retry = 0; retry < connectionRetries; retry++) {
      tr = new TFramedTransport(new TSocket(myhost,
          Integer.parseInt(getProperties().getProperty("port", "9160"))));
      TProtocol proto = new TBinaryProtocol(tr);
      client = new Cassandra.Client(proto);
      try {
        tr.open();
        connectexception = null;
        break;
      } catch (Exception e) {
        connectexception = e;
      }
      try {
        Thread.sleep(1000);
      } catch (InterruptedException e) {
        Thread.currentThread().interrupt();
      }
    }
    if (connectexception != null) {
      System.err.println("Unable to connect to " + myhost + " after "
          + connectionRetries + " tries");
      throw new DBException(connectexception);
    }

    if (username != null && password != null) {
      Map<String, String> cred = new HashMap<String, String>();
      cred.put("username", username);
      cred.put("password", password);
      AuthenticationRequest req = new AuthenticationRequest(cred);
      try {
        client.login(req);
      } catch (Exception e) {
        throw new DBException(e);
      }
    }

    cv = new ClientView();
  }

  /**
   * Cleanup any state for this DB. Called once per DB instance; there is one DB
   * instance per client thread.
   */
  public void cleanup() throws DBException {
    tr.close();
  }

  /**
   * Read a record from the database. Each field/value pair from the result will
   * be stored in a HashMap.
   *
   * @param table
   *          The name of the table
   * @param key_strs
   *          A list of the record key of the record to read as rotxn
   * @param fields
   *          The list of fields to read, or null for all of them
   * @param result
   *          A HashMap of map of key to field/value pairs for the result
   * @return Zero on success, a non-zero error code on error
   */
  public Status read(String table, List<String> key_strs, Set<String> fields,
      HashMap<ByteBuffer, HashMap<String, ByteIterator>> result) {
    if (!tableName.equals(table)) {
      try {
        client.set_keyspace(table);
        tableName = table;
      } catch (Exception e) {
        e.printStackTrace();
        e.printStackTrace(System.out);
        return Status.ERROR;
      }
    }

    for (int i = 0; i < operationRetries; i++) {

      try {
        SlicePredicate predicate;
        if (fields == null) {
          predicate = new SlicePredicate().setSlice_range(new SliceRange(
              EMPTY_BYTE_BUFFER, EMPTY_BYTE_BUFFER, false, 1000000));

        } else {
          ArrayList<ByteBuffer> fieldlist =
              new ArrayList<ByteBuffer>(fields.size());
          for (String s : fields) {
            fieldlist.add(ByteBuffer.wrap(s.getBytes("UTF-8")));
          }

          predicate = new SlicePredicate().setColumn_names(fieldlist);
        }

        List<ByteBuffer> keys = new ArrayList<>();
        for (String key : key_strs) {
          keys.add(ByteBuffer.wrap(key.getBytes("UTF-8")));
        }

        Map<ByteBuffer,List<ColumnOrSuperColumn>> results =
            client.multiget_slice(keys, parent,
                predicate, readConsistencyLevel, cv.get_version_to_read(keys));

        if (debug) {
          System.out.print("Reading keys: " + keys);
        }

        Column column;
        String name;
        ByteIterator value;
        for (Map.Entry<ByteBuffer, List<ColumnOrSuperColumn>> entry : results.entrySet()) {
          result.put(entry.getKey(), new HashMap<String, ByteIterator>());
          int most_recent_version = 0;
          for (ColumnOrSuperColumn oneresult : entry.getValue()) {
            column = oneresult.column;
            if (column.most_recent_version > most_recent_version) {
              // for updating client view
              most_recent_version = column.most_recent_version;
            }
            name = new String(column.name.array(),
                    column.name.position() + column.name.arrayOffset(),
                    column.name.remaining());
            value = new ByteArrayByteIterator(column.value.array(),
                    column.value.position() + column.value.arrayOffset(),
                    column.value.remaining());
            result.get(entry.getKey()).put(name, value);
            if (debug) {
              System.out.print("(" + name + "=" + value + ")");
            }
          }
          cv.update_view(entry.getKey(), most_recent_version);  // update client view
        }

        if (debug) {
          System.out.println();
          System.out
              .println("ConsistencyLevel=" + readConsistencyLevel.toString());
        }

        return Status.OK;
      } catch (Exception e) {
        errorexception = e;
      }

      try {
        Thread.sleep(500);
      } catch (InterruptedException e) {
        Thread.currentThread().interrupt();
      }
    }
    errorexception.printStackTrace();
    errorexception.printStackTrace(System.out);
    return Status.ERROR;
  }

  public Status scan(String table, String startkey, int recordcount,
      Set<String> fields, Vector<HashMap<String, ByteIterator>> result) {
    // We don't use scan in Scylla-MOON
    return Status.BAD_REQUEST;
  }

  /**
   * Update a record in the database. Any field/value pairs in the specified
   * values HashMap will be written into the record with the specified record
   * key, overwriting any existing values with the same field name.
   *
   * @param table
   *          The name of the table
   * @param key_strs
   *          The record keys of the records to write.
   * @param values
   *          A HashMap of field/value pairs to update in the record
   * @return Zero on success, a non-zero error code on error
   */
  public Status update(String table, List<String> key_strs,
      HashMap<String, ByteIterator> values) {
    return insert(table, key_strs, values, false);
  }

  /**
   * Insert a record in the database. Any field/value pairs in the specified
   * values HashMap will be written into the record with the specified record
   * key.
   *
   * @param table
   *          The name of the table
   * @param key_strs
   *          The record keys of the records to insert.
   * @param values
   *          A HashMap of field/value pairs to insert in the record
   * @return Zero on success, a non-zero error code on error
   */
  public Status insert(String table, List<String> key_strs,
      HashMap<String, ByteIterator> values, boolean isLoading) {
    if (!tableName.equals(table)) {
      try {
        client.set_keyspace(table);
        tableName = table;
      } catch (Exception e) {
        e.printStackTrace();
        e.printStackTrace(System.out);
        return Status.ERROR;
      }
    }

    for (int i = 0; i < operationRetries; i++) {
      mutations.clear();
      mutationMap.clear();
      record.clear();

      try {
        Column col;
        ColumnOrSuperColumn column;
        for (Map.Entry<String, ByteIterator> entry : values.entrySet()) {
          col = new Column();
          col.setName(ByteBuffer.wrap(entry.getKey().getBytes("UTF-8")));
          col.setValue(ByteBuffer.wrap(entry.getValue().toArray()));
          col.setTimestamp(System.currentTimeMillis());

          column = new ColumnOrSuperColumn();
          column.setColumn(col);

          mutations.add(new Mutation().setColumn_or_supercolumn(column));
        }
        mutationMap.put(columnFamily, mutations);

        for (String key : key_strs) {
          if (debug) {
            System.out.println("Inserting key: " + key);
          }
          ByteBuffer wrappedKey = ByteBuffer.wrap(key.getBytes("UTF-8"));
          record.put(wrappedKey, mutationMap);
        }

        int commit_version = client.batch_mutate(record, writeConsistencyLevel, cv.get_current_read_version(isLoading) + 1);

        // update version_to_read
        cv.set_current_version_to_read(commit_version);

        if (debug) {
          System.out
              .println("ConsistencyLevel=" + writeConsistencyLevel.toString());
        }

        return Status.OK;
      } catch (Exception e) {
        errorexception = e;
      }
      try {
        Thread.sleep(500);
      } catch (InterruptedException e) {
        Thread.currentThread().interrupt();
      }
    }

    errorexception.printStackTrace();
    errorexception.printStackTrace(System.out);
    return Status.ERROR;
  }

  public Status delete(String table, String key) {
    // We don't use delete in Scylla-MOON
    return Status.BAD_REQUEST;
  }
}

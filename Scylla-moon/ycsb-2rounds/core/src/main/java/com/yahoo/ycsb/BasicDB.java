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

package com.yahoo.ycsb;

import java.nio.ByteBuffer;
import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.locks.LockSupport;


/**
 * Basic DB that just prints out the requested operations, instead of doing them against a database.
 */
public class BasicDB extends DB
{
	public static final String VERBOSE="basicdb.verbose";
	public static final String VERBOSE_DEFAULT="true";
	
    public static final String SIMULATE_DELAY="basicdb.simulatedelay";
    public static final String SIMULATE_DELAY_DEFAULT="0";
    
    public static final String RANDOMIZE_DELAY="basicdb.randomizedelay";
    public static final String RANDOMIZE_DELAY_DEFAULT="true";
    
	
    boolean verbose;
    boolean randomizedelay;
	int todelay;

	public BasicDB()
	{
		todelay=0;
	}

	
	void delay()
	{
		if (todelay>0)
		{
		    long delayNs;
		    if (randomizedelay) {
		        delayNs = TimeUnit.MILLISECONDS.toNanos(Utils.random().nextInt(todelay));
		        if (delayNs == 0) {
		            return;
		        }
		    }
		    else {
		        delayNs = TimeUnit.MILLISECONDS.toNanos(todelay);
		    }
		    
		    long now = System.nanoTime();
            final long deadline = now + delayNs;
            do {
                LockSupport.parkNanos(deadline - now);
            } while ((now = System.nanoTime()) < deadline && !Thread.interrupted());
		}
	}

	/**
	 * Initialize any state for this DB.
	 * Called once per DB instance; there is one DB instance per client thread.
	 */
	@SuppressWarnings("unchecked")
	public void init()
	{
		verbose=Boolean.parseBoolean(getProperties().getProperty(VERBOSE, VERBOSE_DEFAULT));
		todelay=Integer.parseInt(getProperties().getProperty(SIMULATE_DELAY, SIMULATE_DELAY_DEFAULT));
		randomizedelay=Boolean.parseBoolean(getProperties().getProperty(RANDOMIZE_DELAY, RANDOMIZE_DELAY_DEFAULT));
		if (verbose)
		{
			System.out.println("***************** properties *****************");
			Properties p=getProperties();
			if (p!=null)
			{
				for (Enumeration e=p.propertyNames(); e.hasMoreElements(); )
				{
					String k=(String)e.nextElement();
					System.out.println("\""+k+"\"=\""+p.getProperty(k)+"\"");
				}
			}
			System.out.println("**********************************************");
		}
	}

	/**
	 * Read a record from the database. Each field/value pair from the result will be stored in a HashMap.
	 *
	 * @param table The name of the table
	 * @param key_strs The record keys of the records to read.
	 * @param fields The list of fields to read, or null for all of them
	 * @param result A HashMap of field/value pairs for the result
	 * @return Zero on success, a non-zero error code on error
	 */
	public Status read(String table, List<String> key_strs, Set<String> fields, HashMap<ByteBuffer, HashMap<String, ByteIterator>> result)
	{
		delay();

		if (verbose)
		{
			System.out.print("READ "+table+" "+key_strs+" [ ");
			if (fields!=null)
			{
				for (String f : fields)
				{
					System.out.print(f+" ");
				}
			}
			else
			{
				System.out.print("<all fields>");
			}

			System.out.println("]");
		}

		return Status.OK;
	}
	
	/**
	 * Perform a range scan for a set of records in the database. Each field/value pair from the result will be stored in a HashMap.
	 *
	 * @param table The name of the table
	 * @param startkey The record key of the first record to read.
	 * @param recordcount The number of records to read
	 * @param fields The list of fields to read, or null for all of them
	 * @param result A Vector of HashMaps, where each HashMap is a set field/value pairs for one record
	 * @return Zero on success, a non-zero error code on error
	 */
	public Status scan(String table, String startkey, int recordcount, Set<String> fields, Vector<HashMap<String,ByteIterator>> result)
	{
		delay();

		if (verbose)
		{
			System.out.print("SCAN "+table+" "+startkey+" "+recordcount+" [ ");
			if (fields!=null)
			{
				for (String f : fields)
				{
					System.out.print(f+" ");
				}
			}
			else
			{
				System.out.print("<all fields>");
			}

			System.out.println("]");
		}

		return Status.OK;
	}

	/**
	 * Update a record in the database. Any field/value pairs in the specified values HashMap will be written into the record with the specified
	 * record key, overwriting any existing values with the same field name.
	 *
	 * @param table The name of the table
	 * @param key_strs The record keys of the records to write.
	 * @param values A HashMap of field/value pairs to update in the record
	 * @return Zero on success, a non-zero error code on error
	 */
	public Status update(String table, List<String> key_strs, HashMap<String,ByteIterator> values)
	{
		delay();

		if (verbose)
		{
			System.out.print("UPDATE "+table+" "+key_strs+" [ ");
			if (values!=null)
			{
				for (Map.Entry<String, ByteIterator> entry : values.entrySet())
				{
					System.out.print(entry.getKey() +"="+ entry.getValue() +" ");
				}
			}
			System.out.println("]");
		}

		return Status.OK;
	}

	/**
	 * Insert a record in the database. Any field/value pairs in the specified values HashMap will be written into the record with the specified
	 * record key.
	 *
	 * @param table The name of the table
	 * @param key_strs The record key of the record to insert.
	 * @param values A HashMap of field/value pairs to insert in the record
	 * @return Zero on success, a non-zero error code on error
	 */
	public Status insert(String table, List<String> key_strs, HashMap<String,ByteIterator> values, boolean isLoading)
	{
		delay();

		if (verbose)
		{
			System.out.print("INSERT "+table+" "+key_strs+" [ ");
			if (values!=null)
			{
				for (Map.Entry<String, ByteIterator> entry : values.entrySet())
				{
					System.out.print(entry.getKey() +"="+ entry.getValue() +" ");
				}
			}

			System.out.println("]");
		}

		return Status.OK;
	}


	/**
	 * Delete a record from the database. 
	 *
	 * @param table The name of the table
	 * @param key The record key of the record to delete.
	 * @return Zero on success, a non-zero error code on error
	 */
	public Status delete(String table, String key)
	{
		delay();

		if (verbose)
		{
			System.out.println("DELETE "+table+" "+key);
		}

		return Status.OK;
	}

	/**
	 * Short test of BasicDB
	 */
	/*
	public static void main(String[] args)
	{
		BasicDB bdb=new BasicDB();

		Properties p=new Properties();
		p.setProperty("Sky","Blue");
		p.setProperty("Ocean","Wet");

		bdb.setProperties(p);

		bdb.init();

		HashMap<String,String> fields=new HashMap<String,String>();
		fields.put("A","X");
		fields.put("B","Y");

		bdb.read("table","key",null,null);
		bdb.insert("table","key",fields);

		fields=new HashMap<String,String>();
		fields.put("C","Z");

		bdb.update("table","key",fields);

		bdb.delete("table","key");
	}*/
}


#!/bin/bash


echo "starting all daemons......"
start-all.sh
mr-jobhistory-daemon.sh start historyserver
jps

echo "all daemons are running....."

echo "deleting directory....."
hadoop fs -rm -r /project_data
echo "directory deleted"

echo "creating directory....."
hadoop fs -mkdir -p /project_data
echo "directory created"

echo "transfering data from local filesystem to hdfs using flume"
flume-ng agent -n agent1 -c conf -f /home/chetan/Desktop/apache-flume-1.6.0-bin/conf/flume.conf

echo "deleting directory....."
hadoop fs -rm -r /project_data/xml_to_csv
echo "directory deleted"

echo "converting xml file to csv"
pig xml_parse.pig
echo "file conversion completed"

echo "deleting directory....."
hadoop fs -rm -r /project_data/q1
echo "directory deleted"

echo "running 1st pig script"
pig q1
echo "1st pig script completed"

echo "exporting data to mysql using sqoop"
sqoop export --connect jdbc:mysql://localhost/project --driver com.mysql.jdbc.Driver --username root --password password --table q1 --export-dir /project_data/q1/part-m-00000
echo "data exported to mysql"

echo "deleting directory....."
hadoop fs -rm -r /project_data/q2
echo "directory deleted"

echo "moving jar file for udf from local filesystem to hdfs"
hadoop fs -put /home/chetan/Desktop/test.jar /project_data
echo "jar file moved to hdfs" 

echo "running 2nd pig script"
pig q2
echo "2nd pig script completed"

echo "exporting data to mysql using sqoop"
sqoop export --connect jdbc:mysql://localhost/project --driver com.mysql.jdbc.Driver --username root --password password --table q2 --export-dir /project_data/q2/part-m-00000
echo "data exported to mysql"







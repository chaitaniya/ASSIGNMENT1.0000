#!/bin/bash


sleep 40
kill $(ps -ef | grep flume | awk '{ print $2 }')
echo "flume job finished"

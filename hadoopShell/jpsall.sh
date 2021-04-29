#!/bin/bash
#显示各个服务器的jps命令

for host in master slave1 slave2
do
	echo "==================$host====================="
	ssh $host jps
done
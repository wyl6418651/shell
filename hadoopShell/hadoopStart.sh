#!/bin/bash

#群起hdfs集群，和yarn集群
#参数个数判断s
if (($# != 1 ))
	then
		echo "请输入一个的参数"
		exit
fi
#群起集群
hadoop_start(){
	echo "------------------------->   启动hdfs   <----------------------------------"
	ssh master "/opt/module/hadoop-3.1.4/sbin/start-dfs.sh"
	echo "------------------------->   启动yarn   <----------------------------------"
	ssh slave1 "/opt/module/hadoop-3.1.4/sbin/start-yarn.sh"
	echo "------------------------->   启动historyserver  <----------------------------------"
	ssh master "/opt/module/hadoop-3.1.4/bin/mapred --daemon start historyserver"
}

#关闭集群
hadoop_stop(){
	echo "------------------------->   关闭historyserver  <----------------------------------"
	ssh master "/opt/module/hadoop-3.1.4/bin/mapred --daemon stop historyserver"
	echo "------------------------->   关闭yarn   <----------------------------------"
	ssh slave1 "/opt/module/hadoop-3.1.4/sbin/stop-yarn.sh"
	echo "------------------------->   关闭hdfs   <----------------------------------"
	ssh master "/opt/module/hadoop-3.1.4/sbin/stop-dfs.sh"
}

#启动hdfs和yarn
case $1 in
"start")
	hadoop_start
;;
"stop")
	hadoop_stop
;;
"restart")
	hadoop_stop
	hadoop_start
;;
*)
	echo "你输入的参数是错误的"
;;
esac
#群起集群

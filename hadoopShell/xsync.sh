#!/bin/bash

#判断输入的参数是否为空
if (($# < 1))
    then
        echo "请输入参数"
	exit
fi


#集群分发文件
for host in master slave1 slave2
do	
	echo "===================${host}================"
	# 遍历所有目录挨个发送
	
	for file in $*
	do
		if [ -e $file ]
			then
				#获取父目录
				pdir=$(cd -P $(dirname $file);pwd)
				#获取当前文件的名称
				fname=$(basename $file)
				ssh $host "mkdir -p ${pdir}"
				rsync -av $pdir/$fname $host:$pdir
			else
				echo "您输入的文件是不存在的"
		fi
	done
done
    

#!/bin/bash
# pwd
pwd=xxx
#读取IP列表行数
lineNumber=`cat iplist.txt |wc -l`
#设置计数参数
count=0
#循环读取IP并测试
for i in `cat ./iplist.txt`
do
  #计数器
  count=$((count+1))
  #控制台打印当前进度
  echo "${i} ${count}/${lineNumber}"
  # ssh连接测试
  sshpass -p $pwd  ssh -o ConnectTimeout=3 -o StrictHostKeyChecking=no root@$i "echo 'hello world'" >/dev/null 2>&1
  if [ $? -eq 0 ]
    then
            echo "${i}|true" >> ./st_result.txt
    else
            echo "${i}|fail" >> ./st_result.txt
  fi

done

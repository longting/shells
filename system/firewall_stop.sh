#!/bin/bash

# 关闭防火墙

#设置登录信息
user=root
pwd=P@ssw0rd

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
  ## 登录
  sshpass -p $pwd ssh $user@$i "systemctl stop firewalld && systemctl disable firewalld"  

done

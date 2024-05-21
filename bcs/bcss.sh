#!/bin/bash

# 安装包目录结构
# /root/bcs_install/BES-CACHESERVER-3.2.0.1608-KYLIN10-FT-64.tar.gz
# /root/bcs_install/patch/

user=root
pwd=P@ssw0rd
filename="BES-CACHESERVER-3.2.0.1608-KYLIN10-FT-64.tar.gz"
installDir="/root/bcs_install"
unpackage="/opt/bcs/"
patchDir="/opt/bcs_install/patch/"
#patchIns="$unpackage/bin/patch  -path $installDir/patch/"
installPkg="/opt/bcs_install/$filename"

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
  sshpass -p $pwd  scp -r $installDir $user@$i:/opt
  ## 登录
  sshpass -p $pwd ssh $user@$i "cd /opt &&  mkdir $unpackage && tar -zxf $installPkg -C $unpackage && $unpackage/bin/patch  -path $patchDir && $unpackage/bin/startManagement"  

done

#!/bin/bash

# 安装包目录结构
# /root/bes_install/安装包
# /root/bes_install/patch/

# iplist.txt  格式ip,端口
# 192.168.1.1,8080
# 192.168.1.2,8081

user=root
pwd=P@ssw0rd
filename="BES-AppServer-Standard-9.5.5.7266.tar.gz"
installDir="/root/bes_install"
unpackage="/data/bes/"
patchDir="/data/bes_install/patch/"
#patchIns="$unpackage/bin/patch  -path $installDir/patch/"
installPkg="/data/bes_install/$filename"

#读取IP列表行数
lineNumber=`cat iplist.txt |wc -l`
#设置计数参数 
count=0
#循环读取IP并测试
for i in `cat ./iplist.txt`
do
  #计数器
  count=$((count+1))
  array=(`echo ${i} | tr ',' ' '` )
  ip=${array[0]}
  port=${array[1]}
  #控制台打印当前进度
  echo "${ip} ${count}/${lineNumber}"
  sshpass -p $pwd  scp -r $installDir $user@$ip:/data
  # configserver   --user=admin  --password=B#2008_2108#es  --adminuser=admin  --adminpassword=B#2008_2108#es  --adminhost=0.0.0.0  --adminport=1900  --userhost=0.0.0.0  --userport=$port
  # iastool --passport B#2008_2108#es --user admin --password B#2008_2108#es start --server
  ## 登录
  sshpass -p $pwd ssh $user@$ip "cd /data &&  mkdir $unpackage && tar -zxf $installPkg -C $unpackage && $unpackage/bin/patch  -path $patchDir && $unpackage/bin/configserver   --user=admin  --password=B#2008_2108#es  --adminuser=admin  --adminpassword=B#2008_2108#es  --adminhost=0.0.0.0  --adminport=1900  --userhost=0.0.0.0  --userport=$port && $unpackage/bin/iastool --passport B#2008_2108#es --user admin --password B#2008_2108#es start --server"  

done

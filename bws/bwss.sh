#!/bin/bash


# 1. 先从宿主机拷贝jdk压缩包到/opt目录下
# 2. 解压jdk压缩包到/opt目录下
# 3. 建立jdk文件路径
# 4. 配置java环境变量
# 5. 重新加载配置文件 
 
user=root
pwd=P@ssw0rd
filename="BES-WEBSERVER-STANDALONE-3.1.0.1106-KYLIN10-FT-64.tar.gz"
installDir="/root/bws_install"
unpackage="/opt/bws/"
envFile="/root/.bashrc"
patchDir="/opt/bws_install/patch/"
#patchIns="$unpackage/bin/patch  -path $installDir/patch/"
installPkg="/opt/bws_install/$filename"

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
  sshpass -p $pwd ssh $user@$i "cd /opt &&  mkdir $unpackage && tar -zxf $installPkg -C $unpackage && $unpackage/bin/patch  -path $patchDir && $unpackage/bin/startconsole"  

done

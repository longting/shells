#!/bin/bash


# 1. 先从宿主机拷贝jdk压缩包到/opt目录下
# 2. 解压jdk压缩包到/opt目录下
# 3. 建立jdk文件路径
# 4. 配置java环境变量
# 5. 重新加载配置文件 

user=root
pwd=P@ssw0rd
filename="bisheng-jdk-8u412-linux-aarch64.tar.gz"
jdkTargz="/root/bisheng-jdk-8u412-linux-aarch64.tar.gz"
unpackage="bisheng-jdk1.8.0_412"
envFile="/root/.bashrc"


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
  sshpass -p $pwd  scp -r $jdkTargz $user@$i:/opt
  ## 登录
  #sshpass -p $pwd ssh $user@$i
  sshpass -p $pwd ssh $user@$i "cd /opt && tar -zxf $filename -C /opt && mv $unpackage jdk8 &&  echo -e 'export JAVA_HOME=/opt/jdk8\nexport CLASSPATH=.:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar\nexport PATH=\$JAVA_HOME/bin:\$JAVA_HOME/jre/bin:\$PATH' >> $envFile && source $envFile"  

  #installJDK
  #退出登录
  #exit 0 
done

#!/bin/bash

tar xf mongodb-linux-x86_64-4.0.4.tgz -C /usr/local
mkdir -p /datamongo/{db,logs}
InsDir=/usr/local/mongodb-linux-x86_64-4.0.4

cd $InsDir
mkdir etc/  && cd etc/ && touch mongodb.conf 
cat >$InsDir/etc/mongodb.conf<<EOF
port=27017 #端口
dbpath= /datamongo/db #数据库存文件存放目录
logpath= /datamongo/logs/mongodb.log #日志文件存放路径
logappend=true #使用追加的方式写日志
fork=true #以守护进程的方式运行，创建服务器进程
maxConns=100 #最大同时连接数
#noauth=false #不启用验证
auth=true #不启用验证
journal=true #每次写入会记录一条操作日志（通过journal可以重新构造出写入的数据）。
#即使宕机，启动时wiredtiger会先将数据恢复到最近一次的checkpoint点，然后重放后续的journal日志来恢复。
storageEngine=wiredTiger  #存储引擎有mmapv1、wiretiger、mongorocks
bind_ip = 0.0.0.0  #这样就可外部访问了，例如从win10中去连虚拟机中的MongoDB
EOF

#启动mongodb
$InsDir/bin/mongod -f $InsDir/etc/mongodb.conf

#添加环境变量
cat >>/etc/profile<<EOF
#mongo
PATH=\${PATH}:$InsDir/bin
EOF
#使配置生效
source /etc/profile >/dev/null 2>&1

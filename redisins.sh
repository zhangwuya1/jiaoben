#!/bin/bash
wget http://download.redis.io/releases/redis-3.2.10.tar.gz
tar xf redis-3.2.10.tar.gz -C /usr/local/
cd /usr/local/redis-3.2.10
make && mkdir etc/ bin/ logs && mv src/{redis-benchmark,redis-check-rdb,redis-cli,redis-sentinel,redis-server} bin/
mv redis.conf  etc/
sed -i 's#daemonize no#daemonize yes#g' etc/redis.conf

sed -i 's#logfile ""#logfile /usr/local/redis-3.2.10/logs/redis.log#g' etc/redis.conf
read -p "pls input your password:" MiMa
sed -i "s/# requirepass foobared/requirepass $MiMa/g" etc/redis.conf
 ./bin/redis-server etc/redis.conf

#环境变量
cat >>/etc/profile<<EOF
#redis
PATH=\${PATH}:/usr/local/redis-3.2.10/bin
EOF

source /etc/profile >/dev/null 2>&1




#Set this node as master
#echo "192.168.0.1    master " >> /etc/hosts
mkdir /run/sshd
/usr/sbin/sshd

sleep 10s # Waits 10 seconds.

ssh-copy-id -f master
ssh-copy-id -f slave1
ssh-copy-id -f slave2

bin/hdfs namenode -format

echo "start dfs"
sbin/start-dfs.sh
echo "start yarn"
sbin/start-yarn.sh
echo "endless job"
tail -F ""

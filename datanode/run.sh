mkdir /run/sshd
/usr/sbin/sshd

sleep 10s # Waits 10 seconds.
ssh-copy-id -f master
ssh-copy-id -f slave1
ssh-copy-id -f slave2

tail -F ""

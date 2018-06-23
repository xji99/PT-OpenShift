#!/bin/bash


cat /vagrant/control.pub >> /home/vagrant/.ssh/authorized_keys

yum install wget git net-tools bind-utils yum-utils iptables-services bridge-utils bash-completion kexec-tools sos psacct

yum-config-manager --add-repo https://docs.docker.com/v1.13/engine/installation/linux/repo_files/centos/docker.repo
yum -y install docker-engine-1.13.1
service docker start
systemctl enable docker.service

## configure DNS server on master node
yum -y install bind


sed -i -e "s/listen-on port 53 { 127.0.0.1; };/listen-on port 53 { 0.0.0.0; };/" /etc/named.conf
sed -i -e "s/allow-query     { localhost; };/allow-query     { any; };/" /etc/named.conf


cp /vagrant/db.foo.com /etc/named/

cat << 'EOF' >> /etc/named.rfc1912.zones
zone "foo.com" {
       type master;
       file "/etc/named/db.foo.com";
};
EOF

cat << 'EOF' > /etc/resolv.conf
nameserver 192.168.3.10
EOF

service named restart


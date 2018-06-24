#!/bin/bash

cat /vagrant/control.pub >> /home/vagrant/.ssh/authorized_keys

yum install -y wget git net-tools bind-utils yum-utils iptables-services bridge-utils bash-completion kexec-tools sos psacct

# docker is installed by openshift playbook
#yum-config-manager --add-repo https://docs.docker.com/v1.13/engine/installation/linux/repo_files/centos/docker.repo
#yum -y install docker-engine-1.13.1
#service docker start
#systemctl enable docker.service

## configure DNS server on master node

cat << 'EOF' > /etc/resolv.conf
search foo.com
nameserver 192.168.3.10
EOF

chmod a-w /etc/resolv.conf


subscription-manager repos --enable=rhel-7-server-extras-rpms

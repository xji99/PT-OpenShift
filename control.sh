#!/bin/bash


if [ ! -f "/home/vagrant/.ssh/id_rsa" ]; then
  ssh-keygen -t rsa -N "" -f /home/vagrant/.ssh/id_rsa
fi
cp /home/vagrant/.ssh/id_rsa.pub /vagrant/control.pub

cat << 'SSHEOF' > /home/vagrant/.ssh/config
Host *
  StrictHostKeyChecking no
  UserKnownHostsFile=/dev/null
SSHEOF

chown -R vagrant:vagrant /home/vagrant/.ssh/

### install ansible
yum -y install wget git net-tools bind-utils yum-utils iptables-services bridge-utils bash-completion kexec-tools sos psacct
yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sed -i -e "s/^enabled=1/enabled=0/" /etc/yum.repos.d/epel.repo
yum -y --enablerepo=epel install ansible pyOpenSSL
### end install ansible


## configure DNS server on master node
yum -y install bind


sed -i -e "s/listen-on port 53 { 127.0.0.1; };/listen-on port 53 { any; };/" /etc/named.conf
sed -i -e "s/allow-query     { localhost; };/allow-query     { any; };/" /etc/named.conf


cp /vagrant/db.foo.com /etc/named/

cat << 'EOF' >> /etc/named.rfc1912.zones
zone "foo.com" {
       type master;
       file "/etc/named/db.foo.com";
};
EOF

cat << 'EOF' > /etc/resolv.conf
search foo.com
nameserver 192.168.3.10
EOF
chmod a-w /etc/resolv.conf
chattr +i /etc/resolv.conf

service named restart

iptables -A INPUT -p tcp --dport 53 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -I INPUT -p udp --dport 53 -j ACCEPT
service iptables save
systemctl enable iptables.service
systemctl enable named.service

## end configure DNS

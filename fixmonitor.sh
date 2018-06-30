#!/bin/bash

# fix lack of openshift node NM was not enabled in vagrant/virtualbox env

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

while [ ! -d "/etc/origin/node" ]
do
  echo "no such dir yet"
  sleep 5
done

touch /etc/origin/node/resolv.conf
echo "job done"

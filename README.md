# Ansible install of OpenShift on Redhat EL 7.5   

This projects uses vagrant, ansible and virutal to set up a Redhat Openshift origin env.
The env consiste of three nodes, one of them is provisioned as ansible control box and DNS server for the cluster,
and the other two are openshift nodes.

* Redhat Linux: Version 7.5. It is latest developer version. 
  A redhat virtual box machine is first installed and configured, then exported as Vagrant box 
  for Vagrant auto provision.

* Redhat OpenShift origin: latest version from github distribution.

* Vagrant: version  2.1.1 with hostManager plugin

* Ansible: verision 2.5.5

* Virtualbox: 5.2.12

* Host machine: Developed and tested on three Unbuntu 16.04 LTS boxes. (with 48Gb, 32Gb, 96GB memory respectively), windows 10 Enterprise (32 GB memory).

# Custom build vagrant redhat 7.5 box

A custom redhat 7.5 VM with developer subscription is built as Vagrant template box.
Most of the prerequsite and rpm repository are configured for this project.

# OpenShift origin deploy steps

* checkout PT_OpenShift project

* Then execute following command to bring all nodes up

```
cd PT_OpenShift
tar -xzvf  openshift-ansible.tgz
vagrant up
```
* Go into ansible control node and deploy openshift

```
vagrant ssh 
cd /vagrant/openshift-ansible
ansible-playbook -i ../inventory.txt playbooks/prerequisites.yml 
ansible-playbook -i ../inventory.txt playbooks/deploy_cluster.yml 
```


# Glitches

## Openshift playbook bugs
There are couple bugs in the current tip version of openshift playbook, you have
to manually change the port to 8443 in the following two file for master node

```
roles/openshift_service_catalog/tasks/start_api_server.yml
roles/template_service_broker/tasks/deploy.yml
```

## DNS problem
Openshift requires DNS to be fully functional and requires usage of Linux NetworkManager to handle the network configuration.
While vagrant also want its own DNS proxy setup. This caused deployCluster to fail. 

As a quick workaround, during deployCluster playbook run:
```
vagrant ssh master
sudo /vagrant/fixmonitor.sh

vagrant ssh node1
sudo /vagrant/fixmonitor.sh

```
# Cluster Verification

## couple commands to verify health status
```
oc version
oc get nodes
oc get pods 
oc get pods --all-namespaces
oc describe pod <pod name>

curl -k https://localhost:8443/

```
## Webconsole login

### Adding a test user

The system is set up with htpassword authentication. To create a user:
first log in to master node, then execute:
```
htpasswd /etc/origin/master/htpasswd USERNAME
```
After while, the user will be provisioned without restart server or services.

You also need to temporarily add an entry to host machine's hosts file to point to master.foo.com to your host ip address.
After that, open browser and access openshift webconsol from host machine:

```
https://host:8443/
```


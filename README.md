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

The system contains one ofinstall latest version of 
Redhat OpenShift Origin on Redhat linux. The redhat box is a developer

# Custom build vagrant redhat 7.5 box

A custom redhat 7.5 VM with developer subscription is built as Vagrant template box.


# Cluster Deploy steps

* checkout git repository


* Redhat Linux: Version 7.5. It is latest developer version. 
  A redhat virtual box machine is first installed and configured, then exported as Vagrant box 
  for Vagrant auto provision.

* Redhat OpenShift origin: latest version from github distribution.

* Vagrant: version  2.1.1 with hostManager plugin

* Ansible: verision 2.5.5

The system contains one ofinstall latest version of 
Redhat OpenShift Origin on Redhat linux. The redhat box is a developer

## Custom build vagrant redhat 7.5 box


## Cluster Deploy steps

* checkout git repository

* Then execute following command to bring all nodes up

```
cd PT_Openshit
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

### Openshift playbook bugs
There are couple bugs in the current tip version of openshift playbook, you have
to manually change the port to 8443 in the following two file for master node

```
roles/openshift_service_catalog/tasks/start_api_server.yml
roles/template_service_broker/tasks/deploy.yml
```

### Openshift requires DNS to be fully functional
This impose a challeng in Vagrant setup, since Vagrant want to have its own DNS server 
so it can handle the nodes it managed.

### Openshift requires Linux Network manager to configure network
This causes problem during cluster deployment since in Vagrant env, we have to forcefully
take over the DNS setup. A shell script to fix this is supplied to deal with this situation.



# Cluster Verification

### couple commands to verify health status
```
oc version
oc get nodes
oc get pods 
oc get pods --all-namespaces
oc describe pod <pod name>

curl -k https://localhost:8443/

```
### Webconsole login
The system is set up with htpassword authentication
A tester/tester user account is provisioned.
To access webconsol from host:

```
https://vmhost:port/
```



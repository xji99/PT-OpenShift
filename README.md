## Ansible install of OpenShift on Redhat EL 7.5   

## Custom build vagrant redhat 7.5 box

## Vagrant

Bring system up
```
vagrant up 
```

## Ansible/openshift installation

```
cd openshift-ansible

ansible-playbook -i ../inventory.txt playbooks/prerequisites.yml 
ansible-playbook -i ../inventory.txt playbooks/deploy_cluster.yml 
```

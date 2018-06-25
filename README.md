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

## some problem fix
change bellow files to have correct port 8443

#roles/openshift_service_catalog/tasks/start_api_server.yml
#roles/template_service_broker/tasks/deploy.yml

## Login 
 default system user system:admin,

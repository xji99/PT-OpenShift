# README
#
# Getting Started:
# 1. vagrant plugin install vagrant-hostmanager
# 2. vagrant up
# 3. vagrant ssh
#
# This should put you at the control host
#  with access, by name, to other vms
Vagrant.configure(2) do |config|
  config.hostmanager.enabled = true
  config.vm.box = "xji/rhel7.5"
  config.ssh.insert_key = false

  config.vm.define "controlbox", primary: true do |h|
    h.vm.hostname = "controlbox"
    h.vm.network "private_network", ip: "192.168.3.10"
    h.vm.provision :shell, path: "master.sh"
    h.vm.provider :virtualbox do |vb|
         vb.customize ["modifyvm", :id, "--memory", "8096"]
         vb.customize ["modifyvm", :id, "--cpus", "4"]
    end
  end

  config.vm.define "openshiftMaster" do |h|
    h.vm.hostname = "master"
    h.vm.network "private_network", ip: "192.168.3.101"
    h.vm.provision :shell, path: "node.sh"
  end

  config.vm.define "openshiftNode1" do |h|
    h.vm.hostname = "node1"
    h.vm.network "private_network", ip: "192.168.3.111"
    h.vm.provision :shell, path: "node.sh"
  end
end


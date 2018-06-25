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
    h.vm.hostname = "controlbox.foo.com"
#    h.vm.network "forwarded_port", guest: 8443, host: 8443
    h.vm.network "private_network", ip: "192.168.3.10"
    h.vm.provision :shell, path: "control.sh"
    h.vm.provider :virtualbox do |vb|
         vb.customize ["modifyvm", :id, "--memory", "1024"]
         vb.customize ["modifyvm", :id, "--cpus", "2"]
    end
  end

  config.vm.define "master" do |h|
    h.vm.hostname = "master.foo.com"
    h.vm.network "private_network", ip: "192.168.3.100"
    h.vm.network "forwarded_port", guest: 8443, host: 8443, host_ip: "127.0.0.1"
    h.vm.provision :shell, path: "master.sh"
    h.vm.provider :virtualbox do |vb|
         vb.customize ["modifyvm", :id, "--memory", "8096"]
         vb.customize ["modifyvm", :id, "--cpus", "4"]
    end
  end

  config.vm.define "node1" do |h|
    h.vm.hostname = "node1.foo.com"
    h.vm.network "private_network", ip: "192.168.3.101"
    h.vm.provision :shell, path: "node.sh"
  end
end


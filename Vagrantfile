# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "centos/7"
  config.vm.box_check_update = false
  config.ssh.insert_key = false

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  config.vm.provider "virtualbox" do |v|
    v.linked_clone = true
  end

  config.vm.define :trex do |trex|
    trex.vm.provision "shell", path: "provision_trex.sh"
    trex.vm.network "private_network", virtualbox__intnet: "net_trex", ip: "10.99.97.4"
    trex.vm.network "private_network", virtualbox__intnet: "net_trex", ip: "10.99.97.5"
    trex.vm.network "private_network", virtualbox__intnet: "net_trex1",  ip: "10.99.98.2"
    trex.vm.network "private_network", virtualbox__intnet: "net_trex2",  ip: "10.99.99.2"

    config.vm.provider "virtualbox" do |vb|
      vb.memory = "8096"
      vb.cpus = 4
      vb.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
      vb.customize ["modifyvm", :id, "--nicpromisc3", "allow-all"]
      vb.customize ["modifyvm", :id, "--nicpromisc4", "allow-all"]
      vb.customize ["modifyvm", :id, "--nicpromisc5", "allow-all"]
    end

  end

  # Optional zone
  if ENV['VAGRANT_DUT']
    config.vm.define :dut do |dut|
      dut.vm.hostname = "dut"
      dut.vm.provision "shell", path: "provision_dut.sh"
      dut.vm.network "private_network", virtualbox__intnet: "net_trex1",  ip: "10.99.98.1"
      dut.vm.network "private_network", virtualbox__intnet: "net_trex2",  ip: "10.99.99.1"
      dut.vm.provider :virtualbox do |vb|
            vb.memory = 8096
            vb.cpus = 2
            vb.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
            vb.customize ["modifyvm", :id, "--nicpromisc3", "allow-all"]
      end
    end
  end

end

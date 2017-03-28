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
    trex.vm.network "forwarded_port", guest: 4500, host: 4500
    trex.vm.network "forwarded_port", guest: 4501, host: 4501
    trex.vm.network "forwarded_port", guest: 4507, host: 4507
    trex.vm.network "private_network", virtualbox__intnet: "net_trex", ip: "10.99.97.4"
    trex.vm.network "private_network", virtualbox__intnet: "net_trex", ip: "10.99.97.5"
    trex.vm.network "private_network", virtualbox__intnet: "net_trex1",  ip: "10.99.98.4"
    trex.vm.network "private_network", virtualbox__intnet: "net_trex2",  ip: "10.99.98.5"

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
      dut.vm.network "private_network", virtualbox__intnet: "net_trex1",  ip: "10.99.98.10"
      dut.vm.network "private_network", virtualbox__intnet: "net_trex2",  ip: "10.99.99.10"
      dut.vm.provider :virtualbox do |vb|
            vb.memory = 8096
            vb.cpus = 2
            vb.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
            vb.customize ["modifyvm", :id, "--nicpromisc3", "allow-all"]
      end
    end
  end

end

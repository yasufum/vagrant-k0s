# -*- mode: ruby -*-
# vi: set ft=ruby :

require "./specs"

Vagrant.configure("2") do |config|
  config.vm.box = VBOX_IMG
  config.vm.box_check_update = false
  #config.ssh.insert_key = false

  CONTROLLERS.each do |ctrl|
    config.vm.define ctrl.hostname do |cf|
      cf.vm.hostname = ctrl.hostname
      cf.vm.network "private_network", ip: ctrl.ipaddr
      cf.vm.provider "virtualbox" do |vb|
        vb.cpus = ctrl.cpus
        vb.memory = ctrl.mem
      end
    end
  end

  WORKERS.each do |worker|
    config.vm.define worker.hostname do |cf|
      cf.vm.hostname = worker.hostname
      cf.vm.network "private_network", ip: worker.ipaddr
      cf.vm.provider "virtualbox" do |vb|
        vb.cpus = worker.cpus
        vb.memory = worker.mem
      end
    end
  end
end

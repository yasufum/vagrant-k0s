# -*- mode: ruby -*-
# vi: set ft=ruby :

# The total number of nodes is sum of 1(controller node) + NUM_WORKER(worker nodes)
NUM_WORKER = 2
VBOX_IMG = "bento/ubuntu-22.04"
IP_RANGE_FROM = 100

CTRL_SPEC = {
  hostname: "controller",
  cpus: 4,
  mem: 8 * 1024,
}

WORKER_SPEC = {
  hostname: "worker",  # worker01, worker02
  cpus: 4,
  mem: 4 * 1024,
}

Vagrant.configure("2") do |config|
  config.vm.box = VBOX_IMG
  config.vm.box_check_update = false
  
  config.vm.define CTRL_SPEC[:hostname] do |cf|
    cf.vm.hostname = CTRL_SPEC[:hostname]
    cf.vm.network "private_network", ip: "192.168.56.#{IP_RANGE_FROM}"
    cf.vm.provider "virtualbox" do |vb|
      vb.cpus = CTRL_SPEC[:cpus]
      vb.memory = CTRL_SPEC[:mem]
    end
  end

  NUM_WORKER.times do |i|
    i += 1
    config.vm.define "#{WORKER_SPEC[:hostname]}#{i}" do |cf|
      cf.vm.hostname = "#{WORKER_SPEC[:hostname]}#{i}"
      cf.vm.network "private_network", ip: "192.168.56.#{IP_RANGE_FROM+i}"
      cf.vm.provider "virtualbox" do |vb|
        vb.cpus = WORKER_SPEC[:cpus]
        vb.memory = WORKER_SPEC[:mem]
      end
    end
  end
end

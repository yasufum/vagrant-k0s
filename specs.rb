# The total number of nodes is sum of 1(controller node) + NUM_WORKER(worker nodes)
VBOX_IMG = "bento/ubuntu-22.04"
user = "vagrant"

class K0sNode
  attr_reader :hostname, :user, :ipaddr, :cpus, :mem
  def initialize(hn, user, ipa, cpus, mem, provider="virtualbox")
    @hostname = hn
    @user = user
    @ipaddr = ipa
    @cpus = cpus
    @mem = mem
    @provider = provider
  end

  def keypath()
    ".vagrant/machines/#{@hostname}/#{@provider}/private_key"
  end
end

CONTROLLERS = [
  K0sNode.new("controller", user, "192.168.56.101", 4, 8*1024)
]

WORKERS = [
  K0sNode.new("worker1", user, "192.168.56.201", 4, 4*1024),
  K0sNode.new("worker2", user, "192.168.56.202", 4, 4*1024)
]

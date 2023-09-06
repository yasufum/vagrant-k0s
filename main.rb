#!/usr/bin/env ruby

require "./specs"
require "yaml"

cluster_name = "myk0scluster"
priv_if = "eth1"

ips = []
CONTROLLERS.each {|n| ips << "#{n.user}@#{n.ipaddr}"}
WORKERS.each {|n| ips << "#{n.user}@#{n.ipaddr}"}

str = `k0sctl init --key-path #{keypath} --k0s -n #{cluster_name} -C #{CONTROLLERS.size} #{ips.join(" ")}`
y = YAML.load(str)

(CONTROLLERS + WORKERS).each do |m|
  y["spec"]["hosts"].each do |h|
    if h["ssh"]["address"] == m.ipaddr
      h["ssh"]["keyPath"] = m.keypath
      h["privateInterface"] = priv_if if h["privateInterface"] == "null"
    end
  end
end

puts YAML.dump(y)

# vagrant-k0s

Setup k0s VM cluster with vagrant.

## Usage

### Launch VMs

Edit `specs.rb` defines specs of each VM nodes first.
You're required to specify specs as a list of contoller and worker nodes.

```rb
CONTROLLERS = [
  K0sNode.new("controller", user, "192.168.56.101", 4, 8*1024)
]

WORKERS = [
  K0sNode.new("worker1", user, "192.168.56.201", 4, 4*1024),
  K0sNode.new("worker2", user, "192.168.56.202", 4, 4*1024)
]
```

`Vagrantfile` is designed to include the specs and do all configuration for
k0s cluster while running `vagrant up`,
so you don't need to edit `Vagrantfile` itself.
Run the command then.

```sh
$ vagrant up
```

### Install k0s

After the VMs launched, you're ready to install k0s on each VMs with
`k8sctl` command.

Generate a config for setting up k0s cluster. `main.rb` is for generating
the config with your specs.

```sh
$ ruby main.rb > my-k0s-config.yaml
```

It generate a `Cluster` kind spec for `k0sctl` which includes all controllers
and workers.

To install k0s on the each nodes, you just run `k0sctl` with the spec.
`--no-wait` and `-d` options are optional.

```sh
$ k0sctl apply --config my-k0s-config.yaml --no-wait -d
```

If you succeed to setup your k0s cluster, get kubeconfig from the cluster then.

```sh
$ k0sctl kubeconfig --config my-k0s-config.yaml > k0s.kubeconfig
```

Now you can access to k0s controller node from `kubectl` as similar to k8s.

```sh
$ kubectl get nodes --kubeconfig k0s.kubeconfig
```

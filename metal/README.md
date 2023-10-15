# Install Talos on Cluster with PXE

## Requirements

- nodes set up with PXE boot
- C2 on the same subnet/vlan
- nix-shell OR
  - wakeonlan
  - xz

## Setup

1. Download the latest PXE Boot artifacts:
```
wget -O <link> ./images/talos-initramfs.xz
wget -O <link> ./images/talos-vmlinuz
```

2. Generate configs
```
cd configs
talosctl gen secrets -o secrets.yaml
talosctl gen configs --with-secrets secrets.yaml talos-general https://10.3.0.50:6443  # going with the VIP HA architecture
```

3. [Optional] Customize configs OR update compose.yaml

- Copy the `controlplane.yaml` to the `${mac}.yaml` of each machine. This is required if hosting specialized configs per
  machine. This is on by default to set the hostname by setting the `talos.configs` kernel param in the `compose.yaml` file.
- Set up installation to disk if desired (not on by default)
- Set up networking
- Set up hostname


## Install Talos Linux

```
# install dependencies
nix-shell

# run pixiecore and static fileserver
task run-pixiecore:talos

# boot over lan
task boot 

# Proceed with cluster set with talosctl
```

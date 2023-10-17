# Install Talos on Cluster with PXE

## Requirements

- nodes set up with PXE boot
  - Note: a lot of ARM SBCs do not support PXE boot, so keep this in mind
- C2 machine (command & control) on the same subnet/vlan with:
  - go-task
  - wakeonlan

## Setup

1. Download the latest PXE Boot artifacts:
```
wget -O <link> ./image/talos-initramfs.xz
wget -O <link> ./image/talos-vmlinuz
```

2. Generate Talos configs
```
cd configs
talosctl gen secrets -o secrets.yaml
talosctl gen configs --with-secrets secrets.yaml talos-general https://10.3.0.50:6443  # going with the VIP HA architecture
```

3. Customize Talos configs

- Copy the `controlplane.yaml` to the `${mac}.yaml` of each machine. This is required if hosting specialized configs per
  machine. This is on by default to set the hostname by setting the `talos.configs` kernel param in the `compose.yaml` file.
- Set up installation to disk if desired (not on by default)
- Set up networking
- Set up hostname

4. Update the `NODE_MACS` variable in `Taskfile.yaml` to be a CSV string of the MAC addresses of the nodes to install
   talos on


## Install Talos Linux

```
# run pixiecore and static fileserver
task run-pixiecore:talos

# boot over lan
task boot 

# Proceed with cluster set up with talosctl
# https://www.talos.dev/v1.5/introduction/prodnotes/#further-details-about-talosctl-endpoints-and-nodes
```

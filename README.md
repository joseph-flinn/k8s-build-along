# Homelab K8s Cluster Project

A build along project has been requested for a homelab bare metal cluster. This document is going to be the home base
for such a project. The project assumes going from a simple home network with a wifi router with consumer device a
homelab. It will be covering the following:

- Network design and hardware Node hardware Software Collaboration around automation

## Project Goals

- Build a low cost bare metal kubernetes cluster for a homelab to have a platform to test different kubernetes patterns
- locally

## Network Architecture Overview 

For this project, we are going to be building out a system that includes a wired router, a switch, three k8s nodes, and
a NAS.


:Picture here:


## Hardware 

### Router 

For the router we are going to use [OPNSense](https://opnsense.org/) for the OS. It is a free and open source
router/firewall. For hardware, you’ll need a device that has at least two NICs. Most x86 computers with two NICs will be
sufficient. If there is any doubt that the hardware will run it, I’d look at [this hardware recommendation
list](https://homenetworkguy.com/review/opnsense-hardware-recommendations/#-200-usd). I’ll be using the
[APU6B4](https://teklager.se/en/products/routers/apu6b4-open-source-router). It isn’t going to be the best router for
everyone, but I want the SFP port (which others might not) and I like the philosophy of the company.  If you don’t need
the SFP port but want to go with the same brand, I’d look at APU2E0, APU2E5, or APU4D4.

Why run a router with dedicated hardware instead of in a VM? I like physical NICs and don’t trust the relationship
between a physical NIC and a virtual NIC. Do I have a good reason? Probably not.


### Switch 

There are too many switches out there to give any sort of recommendations (I’m also not an expert in switches). I’m
going to pick up a switch that is 19” rack mountable for a future rack project. I’m going to go with an unmanaged one. I
currently have a Netgear smart switch that has some management and I don’t use it. If you don’t already have a switch,
just think through how many ports you’ll need and pick up one of those.


### Compute Nodes 

Now the interesting part! I’ve decided that I’m going to go with thin client hardware for the compute nodes. They are
x86 which means that most (all?) docker images will be able to run on them. I was originally thinking about a
[Renegade](https://libre.computer/products/roc-rk3328-cc/) cluster, but during my research I came across a few people
that had some trouble with ARM supporting the software that they wanted to run. For the same amount of money (or less),
used thin client hardware can be picked up from ebay or a similar online marketplace.

The best potential computers will have upgradeable RAM (I’ve seen up to 32 GB!), NVMe slots (but more realistically
mSATA since these will be used and not new–which is not the same as NVMe), and a quad core Intel processor. In most k8s
clusters, RAM is going to be the limiting resource especially in a homelab environment. Having a way to expand RAM as
needed will prove valuable in the future with upgrades. Some sort of expandable storage is going to be important.
Any/all of the images that will be run on the node will have to be downloaded locally before they can be run. I used to
run an Ubuntu server on a mini pc with 32 GB storage and routinely ran out of disk space because of the docker images.
Intel processors will remove any issues running specific docker containers. It will also provide flexibility for the
hardware for future uses if the k8s cluster doesn’t have a permanent place in your homelab.


---
title: Kubernetes
last_modified_at: 2024-08-19-T21:00:00-07:00
---

# Kubernetes

I will discuss my Kubernetes (k8s) setup and how I resolved any issues I come across. Prepare to set sail ⛵️


## Setup

I have setup dedicated VMs on my [homelab](/Home-Lab-2) as follows:

| VM name | Physical Host | Role | base-os | Cluster |
| - | - | - | - |
| k8s-controller | ark | controller | Redhat 9.3 | Omega |
| k8s-worker1 | ark | worker | Ubuntu 22.04 LTS | Omega |
| k8s-worker2 | moonbase1 | worker | Ubuntu 22.04 LTS | Omega |
| trainer | ark | controller | Ubuntu 22.04 LTS | Alpha |
| Ironhide | ark | worker | Ubuntu 22.04 LTS | Alpha |

## Clusters

I was taking the training course [Linux Fondation LFS258](https://training.linuxfoundation.org/training/kubernetes-fundamentals/){:target="_blank"} I wanted to have an extra test bed to not interfere with my primary services. Additionally, I will often use this to test new releases of k8s and experiment with other configurations that may be harmful to my primary cluster. I configured my primary cluster, running on k8s-controller and k8s-worker*, as `Omega` and the cluster for training, running on trainer and Ironhide, as `Alpha`. I use `Cluster context` to switch between them in `kubectl` and `k9s` also picks this up and makes changing context easy. The below describes the setup within `Omega` unless otherwise stated.

`kubectl config use-context omega-admin@omega`

I also have set my current namespace using `kubectl config set-context <context> --namespace <namespace>` to not have to keep adding the `-n` flag.

[Autocomplete](https://medium.com/@bm54cloud/how-to-setup-kubectl-zsh-autocompletion-for-macos-2fb4d270cfab){:target="_blank"} helps. I have this in my `.zshrc`

```
#kubernetes autocomplete
autoload -Uz compinit
compinit
source <(kubectl completion zsh)
```

## Namespaces

At the moment I have setup a 'monitoring' namespace for all monitoring related services. I am starting here as I like playing with and learning more about monitoring systems so this seemed like a good place to start.

## MetalLB

To challenge myself and to work better with my networking setup, I opted to use ['metalLB'](https://metallb.universe.tf){:target="_blank"} within the cluster to assign IPs and to handle load balancing when I plan to scale my pods. I assigned the AddressPool the range `10.0.128.0/24` and modified my Unifi Network settings to keep the netmask to a `255.255.0.0` but assign IPs in the range `10.0.0.0/15` (range: 10.0.0.1 - 10.0.127.255 mask: 255.255.128.0) This ensures no IP collisions as I was unable to figure out (at this time) how to make the metalLB interface be assigned via DHCP.

My ideal setup is to have MetalLB appear as a new device (unique MAC) and manage the IP via Unifi Network, keeping all IP configurations managed by the DHCP service.

## Deployments

### ns.monitoring

I have setup the following deployments under the 'monitoring' namespace.

| Name | NFS share root | Description | Public Docs |
| - | - | - | - |
| uptime-kuma | /volume1/metrics/uptime-kuma | System/service monitoring. | [site](https://uptime.kuma.pet){:target="_blank"} |
| Graphite | /volume1/metrics/graphite | Open Source Time Series Database (TSDB) | [site](https://graphiteapp.org){:target="_blank"} |
| Grafana | /volume1/metrics/grafana | Graphing and Alerting platform | [site](https://grafana.com){:target="_blank"} |
| Prometheus | /volume1/metrics/prometheus | Metric scrapper | [site](https://prometheus.io){:target="_blank"} |
| unpoller | (null) | Unifi Prometheus poller | [site](https://unpoller.com) |



## NFS

For persistent storage I have setup a separate NFS share on my Synology NAS and mount the volumes from the pod directly.

// TODO CFS plugin research. Is this actually even being used (?????)

I have noticed that this setup requires that the underlying kubelet has the nfs-utils package installed in order for this to work properly. Trying to launch a pod on a kubelet without this package installed results in a launch error and a backoff status.
 TODO: add to Ansible to install nfs-utils for k8s nodes


## K9s

One of my former colleagues introduced me to k9s and I absolutely enjoy using it. I have found using this to poke through logs has really improved my ability to troubleshoot my configurations while I am performing rapid testing. Likewise, being able to quickly delete a pod or an entire deployment has saved me a lot of typing. The shell launch option has been convenient, if a pod's container has a shell enabled.

9/9, highly recommend [k9s.io](k9s.io){:target="_blank"}


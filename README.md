# Arista ATD Emulation on Containerlab

__Work in Progress__ Stay tuned !

This repository is built to support demo about how to use [Arista Network Automation](https://www.anta.ninja) framework.

Repository is based on [containerlab](https://containerlab.dev/) for lab management, [eos-download](https://github.com/titom73/eos-downloader) for cEOS image management and [Arista AVD](https://avd.arista.com) for configuration management.

## Topology

![atd-lab-topology](diagram.png)

## Documentation

- [Installation](./docs/installation.md)
- [Configuration management](docs/avd-provisioning.md)
- [Step by Step demo](docs/demo.md)

### Deploy lab

```bash
$ cd containerlab-topology

$ sudo containerlab deploy --topo topology.yml
```

### Destroy lab

```bash
$ cd containerlab-topology

$ sudo containerlab destroy --topo topology.yml
```

## Authentication

- Username: __ansible__ (password: `ansible`)
- Username: __arista__ (password: `arista`)

## Management IPs

| Hostname | Managemnt Interface | IP Address      |
| -------- | ------------------- | --------------  |
| Spine1   | Management0         | 192.168.0.10/24 |
| Spine2   | Management0         | 192.168.0.11/24 |
| Leaf1    | Management0         | 192.168.0.12/24 |
| Leaf2    | Management0         | 192.168.0.13/24 |
| Leaf3    | Management0         | 192.168.0.14/24 |
| Leaf4    | Management0         | 192.168.0.15/24 |
| Host1    | Management0         | 192.168.0.16/24 |
| Host2    | Management0         | 192.168.0.17/24 |

## Startup configuration

Devices configuration are saved under [containerlab-topology/configs](containerlab-topology/configs) folder



# Arista Network Testing Automation (ANTA) demo

This repository is built to support demo about how to use [Arista Network Testin Automation](https://www.anta.ninja) framework.

Repository is based on [containerlab](https://containerlab.dev/) for lab management, [eos-download](https://github.com/titom73/eos-downloader) for cEOS image management and [Arista AVD](https://avd.arista.com) for configuration management.

## Containerlab Topology

![atd-lab-topology](diagram.png)

## Getting Started

> [!IMPORTANT]
> Complete [Step by Step demo](docs/demo.md) is available but next commands are a quick-start

* download cEOS in version 4.28.3M

```bash
ardl --token <arista.com token> get eos --version 4.28.3M --image-type cEOS --import-docker
```

* Start initial topology

```bash
cd containerlab-topology
sudo containerlab deploy --topo topology.yml --reconfigure
cd ..
```

* Review ANTA parameters available in [`anta.env`](./anta.env)

```bash
cat anta.env
```

* Load anta parameters

```bash
source anta.env
```

* Run anta testing

```bash
anta nrfu --catalog network-tests/nrfu.yml table 
```

* Analyzed first results.

__Continue with this [step-by-step document](./docs/demo.md)__

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

## More documentation

- [Installation](./docs/installation.md)
- [Configuration management](docs/avd-provisioning.md)
- [Step by Step demo](docs/demo.md)


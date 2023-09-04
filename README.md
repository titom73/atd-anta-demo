# Arista Network Testing Automation (ANTA) demo

This repository is built to support demo about how to use [Arista Network Testing Automation](https://www.anta.ninja) framework.

Repository is based on [containerlab](https://containerlab.dev/) for lab management, [eos-download](https://github.com/titom73/eos-downloader) for cEOS image management

[Installation process](./docs/installation.md) is provided in this page. If required, your can [build your VM for the demo](vm-builder/README.md) on GCP or AWS using this terraform content.

## Available demo

> **Note**
> Please follow [installation process](./docs/installation.md) first !

- [Base demo](docs/demo-base.md): Demonstrate [ANTA](www.anta.ninja) capabilities using cEOS as network endpoints
- [Build your test demo](docs/demo-tests.md): Demonstrate how to build your own ANTA tests library

## Containerlab Topology

![atd-lab-topology](diagram.png)

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

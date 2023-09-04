# Lab Installation

## Python

> **info**
> It is recommended to install everything in a Python virtual environment.

It installs the following packages:

- eos-downloader: to download cEOS image to build topology
- anta: Base engine for network testing
- anta-custom: local package provided by this repository to build your first ANTA tests.

```bash
# Python base
pip install -e .
```
> **Note**
> If you are running this demo into ATD, then you are good to go with [the demos](https://github.com/titom73/atd-anta-demo?tab=readme-ov-file#available-demo)

## Containerlab

Containerlab is engine to run test topology and must be installed prior to launch cEOS instances.

### Linux (recommended)

```bash
# download and install the latest release (may require sudo)
bash -c "$(curl -sL https://get.containerlab.dev)"
```

### Macos

```bash
CLAB_WORKDIR=${PWD}

docker run --rm -it --privileged \
    --network host \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /run/netns:/run/netns \
    --pid="host" \
    -w $CLAB_WORKDIR \
    -v $CLAB_WORKDIR:$CLAB_WORKDIR \
    ghcr.io/srl-labs/clab bash
```

> [!NOTE]
> Full installation notes on [containerlab website](https://containerlab.dev/install/)


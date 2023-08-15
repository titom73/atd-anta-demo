# Lab Installation

## Python libs

> [!IMPORTANT]
> It is recommended to install everything in a Python virtual environment.

```bash
# Python base
pip install -r requirements.txt
```

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

## Ansible

If you want to update EOS configuration, it is recommended to use [Ansible AVD collection](https://avd.arista.com)

```bash
# Ansible collection
ansible-galaxy collection install -r collections.yml

# AVD Python requirements
export ARISTA_AVD_DIR=$(ansible-galaxy collection list arista.avd --format yaml
| head -1 | cut -d: -f1) && pip3 install -r
${ARISTA_AVD_DIR}/arista/avd/requirements.txt
```

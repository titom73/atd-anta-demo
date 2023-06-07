# Lab Installation

## Containerlab

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

> Full installation notes:[containerlab website](https://containerlab.dev/install/)

## Ansible & Python

It is recommended to install everything in a Python virtual environment.

```bash
# Python base
pip install -r requirements.txt

# Ansible collection
ansible-galaxy collection install -r collections.yml

# AVD Python requirements
export ARISTA_AVD_DIR=$(ansible-galaxy collection list arista.avd --format yaml
| head -1 | cut -d: -f1) && pip3 install -r
${ARISTA_AVD_DIR}/arista/avd/requirements.txt
```

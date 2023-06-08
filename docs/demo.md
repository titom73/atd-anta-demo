# Demo step by step

## Network Ready for Use

### Initial steps

* download cEOS in version 4.28.3M

```bash
ardl get eos --version 4.28.3M --image-type cEOS --import-docker
```

* Start initial topology

```bash
cd containerlab-topology
sudo containerlab deploy --topo topology.yml --reconfigure
cd ..
```

* Review ANTA parameters available in [`anta.env`](../anta.env)

```bash
cat anta.env
```

* Load anta parameters

```bash
source anta.env
```

* Run anta testing

```bash
anta nrfu table --catalog network-tests/nrfu.yml
```

> Analyzed first results.

## Focusing on Leaf devices

* Run testing only on leaf devices

```bash
anta nrfu table --catalog network-tests/nrfu.yml --tags leaf
```

* Generate AVD EVPN/VXLAN configuration

```bash
ansible-playbook playbooks/atd-fabric-deploy.yml --tags build
```

* Deploy configuration

```bash
ansible-playbook playbooks/atd-fabric-deploy.yml --tags deploy_eapi
```

* Run test again

```bash
anta nrfu table --catalog network-tests/nrfu.yml --tags leaf
```

> Result should be completely green. NTP association can takes few seconds/minutes to happen

## Get data for a specific command

```bash
anta debug run-cmd -c "show lldp neighbors" --device spine01
```

## Collect Data from network

* Edit list of command to capture

```bash
vim network-tests/snapshot.yml
```

* Capture commmands

```bash
anta exec snapshot -c network-tests/snapshot.yml
```


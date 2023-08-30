# ANTA Demo step by step

## Network Ready for Use

### Initial steps

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
anta nrfu --catalog network-tests/nrfu.yml table
```

> Analyzed first results.

* Update NRFU tests to with
    * Under test `VerifyBGPIPv4UnicastCount:` update `number: 4`
    * Under test `VerifyLoopbackCount:` update `number: 1`

* Run anta testing

```bash
anta nrfu --catalog network-tests/nrfu.yml table
```

## Focusing on Leaf devices

* Run testing only on leaf devices

```bash
anta nrfu --catalog network-tests/nrfu.yml table --tags leaf
```

## Get tests for a specific device

```bash
anta debug run-cmd -c "show lldp neighbors" --device spine01
```

## Group result per test or per device

```bash
anta nrfu -c network-tests/nrfu.yml table --group-by device
anta nrfu -c network-tests/nrfu.yml table --group-by test
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

## Build your test - WIP

### Capture output from device

#### Using JSON format (recommended)

```bash
anta debug run-template -d leaf01 -t "show interfaces  Vlan{vlan}" vlan 110
Run templated command 'show interfaces  Vlan{vlan}' with {'vlan': '110'} on leaf01
{
    'interfaces': {
        'Vlan110': {
            'lastStatusChangeTimestamp': 1690457976.3441808,
            'name': 'Vlan110',
            'interfaceStatus': 'connected',
            'burnedInAddress': '00:1c:73:33:03:d8',
            'l2Mru': 0,
            'mtu': 1500,
            'hardware': 'vlan',
            'bandwidth': 0,
            'forwardingModel': 'routed',
            'lineProtocolStatus': 'up',
            'l3MtuConfigured': False,
            'interfaceAddress': [{'secondaryIpsOrderedList': [], 'broadcastAddress': '255.255.255.255', 'virtualSecondaryIps': {}, 'dhcp': False, 'secondaryIps': {}, 'primaryIp': {'maskLen': 0, 'address': '0.0.0.0'}, 'virtualSecondaryIpsOrderedList': [], 'virtualIp': {'maskLen': 24, '
address': '10.1.10.1'}}],
            'physicalAddress': '00:1c:73:33:03:d8',
            'description': 'Tenant_A_OP_Zone_1'
        }
    }
}
```

#### Using TEXT format

```bash
anta debug run-template -d leaf01 -t "show interfaces  Vlan{vlan}" --ofmt text vlan 110
Run templated command 'show interfaces  Vlan{vlan}' with {'vlan': '110'} on leaf01
Vlan110 is up, line protocol is up (connected)
  Hardware is Vlan, address is 001c.7333.03d8 (bia 001c.7333.03d8)
  Description: Tenant_A_OP_Zone_1
  Internet address is virtual 10.1.10.1/24
  Broadcast address is 255.255.255.255
  IP MTU 1500 bytes (default)
  Up 2 hours, 19 minutes, 21 seconds

```

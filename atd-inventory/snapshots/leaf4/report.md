# leaf4 Commands Output

## Table of Contents

- [show lldp neighbors](#show-lldp-neighbors)
- [show ip interface brief](#show-ip-interface-brief)
- [show interfaces description](#show-interfaces-description)
- [show version](#show-version)
- [show running-config](#show-running-config)
## show interfaces description

```
Interface                      Status         Protocol           Description
Et1                            up             up                 MLAG_PEER_leaf3_Ethernet1
Et2                            up             up                 P2P_LINK_TO_SPINE1_Ethernet5
Et3                            up             up                 P2P_LINK_TO_SPINE2_Ethernet5
Et4                            up             up                 host2_Eth3
Et5                            up             up                 host2_Eth4
Et6                            up             up                 
Lo0                            up             up                 EVPN_Overlay_Peering
Lo1                            up             up                 VTEP_VXLAN_Tunnel_Source
Lo100                          up             up                 Tenant_A_OP_Zone_VTEP_DIAGNOSTICS
Ma0                            up             up                 oob_management
Po1                            up             up                 MLAG_PEER_leaf3_Po1
Po4                            up             up                 host2_PortChanne1
Vl110                          up             up                 Tenant_A_OP_Zone_1
Vl1199                         up             up                 
Vl3009                         up             up                 MLAG_PEER_L3_iBGP: vrf Tenant_A_OP_Zone
Vl4093                         up             up                 MLAG_PEER_L3_PEERING
Vl4094                         up             up                 MLAG_PEER
Vx1                            up             up                 leaf4_VTEP
```
## show ip interface brief

```
Address
Interface       IP Address           Status     Protocol         MTU    Owner  
--------------- -------------------- ---------- ------------ ---------- -------
Ethernet2       172.31.255.13/31     up         up              1500           
Ethernet3       172.31.255.15/31     up         up              1500           
Loopback0       192.0.255.6/32       up         up             65535           
Loopback1       192.0.254.5/32       up         up             65535           
Loopback100     10.255.1.6/32        up         up             65535           
Management0     192.168.0.15/24      up         up              1500           
Vlan110         10.1.10.1/24         up         up              1500           
Vlan1199        unassigned           up         up              9164           
Vlan3009        10.255.251.5/31      up         up              1500           
Vlan4093        10.255.251.5/31      up         up              1500           
Vlan4094        10.255.252.5/31      up         up              1500
```
## show lldp neighbors

```
Last table change time   : 0:31:05 ago
Number of table inserts  : 13
Number of table deletes  : 0
Number of table drops    : 0
Number of table age-outs : 0

Port          Neighbor Device ID       Neighbor Port ID    TTL
---------- ------------------------ ---------------------- ---
Et1           leaf3.atd.lab            Ethernet1           120
Et2           spine1.atd.lab           Ethernet5           120
Et3           spine2.atd.lab           Ethernet5           120
Et4           host2.atd.lab            Ethernet2           120
Et5           host2.atd.lab            Ethernet4           120
Et6           leaf3.atd.lab            Ethernet6           120
Ma0           host2.atd.lab            Management0         120
Ma0           spine1.atd.lab           Management0         120
Ma0           host1.atd.lab            Management0         120
Ma0           spine2.atd.lab           Management0         120
Ma0           leaf3.atd.lab            Management0         120
Ma0           leaf2.atd.lab            Management0         120
Ma0           leaf1.atd.lab            Management0         120
```
## show running-config

```
! Command: show running-config
! device: leaf4 (cEOSLab, EOS-4.28.3M-28837868.4283M (engineering build))
!
no aaa root
!
username admin privilege 15 role network-admin nopassword
username ansible privilege 15 role network-admin secret sha512 $6$Dzu11L7yp9j3nCM9$FSptxMPyIL555OMO.ldnjDXgwZmrfMYwHSr0uznE5Qoqvd9a6UdjiFcJUhGLtvXVZR1r.A/iF5aAt50hf/EK4/
username arista privilege 15 role network-admin secret sha512 $6$7WhvEi5Ce5f5Ut3z$Ethmha7rb710RKsaVteusVOuNP1Utfjzse58xxbgiZp4MF0fp7BX5lAw8yBgv/HWCihVomuCSrsJx8wKnJ7Tm1
username tom privilege 15 role network-admin secret sha512 $6$TyWn7NeXe/vBRl1t$S4fEOkPmpTGz7TLHCzDNP8D2UfpO3ciC2MuGmCaFMVF3B7zt9KSnt9yq99y69XBIY1HV/kO4QjOk32yRQOru5.
!
daemon TerminAttr
   exec /usr/bin/TerminAttr -cvaddr=10.73.1.238:9910 -cvauth=token,/tmp/token -cvvrf=default -cvsourceip=192.168.0.15 -cvgnmi -smashexcludes=ale,flexCounter,hardware,kni,pulse,strata -ingestexclude=/Sysdb/cell/1/agent,/Sysdb/cell/2/agent -taillogs
   no shutdown
!
vlan internal order ascending range 1006 1199
!
transceiver qsfp default-mode 4x10G
!
service routing protocols model multi-agent
!
hostname leaf4
ip name-server vrf default 8.8.8.8
ip name-server vrf default 192.168.2.1
dns domain atd.lab
!
spanning-tree mode mstp
no spanning-tree vlan-id 4093-4094
spanning-tree mst 0 priority 16384
!
vlan 110
   name Tenant_A_OP_Zone_1
!
vlan 160
   name Tenant_A_VMOTION
!
vlan 3009
   name MLAG_iBGP_Tenant_A_OP_Zone
   trunk group LEAF_PEER_L3
!
vlan 4093
   name LEAF_PEER_L3
   trunk group LEAF_PEER_L3
!
vlan 4094
   name MLAG_PEER
   trunk group MLAG
!
vrf instance Tenant_A_OP_Zone
!
management api http-commands
   no shutdown
   !
   vrf default
      no shutdown
!
aaa authorization exec default local
!
interface Port-Channel1
   description MLAG_PEER_leaf3_Po1
   switchport trunk allowed vlan 2-4094
   switchport mode trunk
   switchport trunk group LEAF_PEER_L3
   switchport trunk group MLAG
!
interface Port-Channel4
   description host2_PortChanne1
   switchport trunk allowed vlan 110
   switchport mode trunk
   mlag 4
!
interface Ethernet1
   description MLAG_PEER_leaf3_Ethernet1
   channel-group 1 mode active
!
interface Ethernet2
   description P2P_LINK_TO_SPINE1_Ethernet5
   no switchport
   ip address 172.31.255.13/31
!
interface Ethernet3
   description P2P_LINK_TO_SPINE2_Ethernet5
   no switchport
   ip address 172.31.255.15/31
!
interface Ethernet4
   description host2_Eth3
   channel-group 4 mode active
!
interface Ethernet5
   description host2_Eth4
   channel-group 4 mode active
!
interface Ethernet6
!
interface Loopback0
   description EVPN_Overlay_Peering
   ip address 192.0.255.6/32
!
interface Loopback1
   description VTEP_VXLAN_Tunnel_Source
   ip address 192.0.254.5/32
!
interface Loopback100
   description Tenant_A_OP_Zone_VTEP_DIAGNOSTICS
   vrf Tenant_A_OP_Zone
   ip address 10.255.1.6/32
!
interface Management0
   description oob_management
   ip address 192.168.0.15/24
!
interface Vlan110
   description Tenant_A_OP_Zone_1
   vrf Tenant_A_OP_Zone
   ip address virtual 10.1.10.1/24
!
interface Vlan3009
   description MLAG_PEER_L3_iBGP: vrf Tenant_A_OP_Zone
   vrf Tenant_A_OP_Zone
   ip address 10.255.251.5/31
!
interface Vlan4093
   description MLAG_PEER_L3_PEERING
   ip address 10.255.251.5/31
!
interface Vlan4094
   description MLAG_PEER
   no autostate
   ip address 10.255.252.5/31
!
interface Vxlan1
   description leaf4_VTEP
   vxlan source-interface Loopback1
   vxlan virtual-router encapsulation mac-address mlag-system-id
   vxlan udp-port 4789
   vxlan vlan 110 vni 10110
   vxlan vlan 160 vni 55160
   vxlan vrf Tenant_A_OP_Zone vni 10
!
ip virtual-router mac-address 00:1c:73:00:dc:01
ip address virtual source-nat vrf Tenant_A_OP_Zone address 10.255.1.6
!
ip routing
ip routing vrf Tenant_A_OP_Zone
!
ip prefix-list PL-LOOPBACKS-EVPN-OVERLAY
   seq 10 permit 192.0.255.0/24 eq 32
   seq 20 permit 192.0.254.0/24 eq 32
!
mlag configuration
   domain-id pod2
   local-interface Vlan4094
   peer-address 10.255.252.4
   peer-link Port-Channel1
   reload-delay mlag 300
   reload-delay non-mlag 330
!
ip route 0.0.0.0/0 192.168.0.1
!
route-map RM-CONN-2-BGP permit 10
   match ip address prefix-list PL-LOOPBACKS-EVPN-OVERLAY
!
route-map RM-MLAG-PEER-IN permit 10
   description Make routes learned over MLAG Peer-link less preferred on spines to ensure optimal routing
   set origin incomplete
!
router bfd
   multihop interval 1200 min-rx 1200 multiplier 3
!
router bgp 65102
   router-id 192.0.255.6
   no bgp default ipv4-unicast
   distance bgp 20 200 200
   graceful-restart restart-time 300
   graceful-restart
   maximum-paths 4 ecmp 4
   neighbor EVPN-OVERLAY-PEERS peer group
   neighbor EVPN-OVERLAY-PEERS update-source Loopback0
   neighbor EVPN-OVERLAY-PEERS bfd
   neighbor EVPN-OVERLAY-PEERS ebgp-multihop 3
   neighbor EVPN-OVERLAY-PEERS password 7 q+VNViP5i4rVjW1cxFv2wA==
   neighbor EVPN-OVERLAY-PEERS send-community
   neighbor EVPN-OVERLAY-PEERS maximum-routes 0
   neighbor IPv4-UNDERLAY-PEERS peer group
   neighbor IPv4-UNDERLAY-PEERS password 7 AQQvKeimxJu+uGQ/yYvv9w==
   neighbor IPv4-UNDERLAY-PEERS send-community
   neighbor IPv4-UNDERLAY-PEERS maximum-routes 12000
   neighbor MLAG-IPv4-UNDERLAY-PEER peer group
   neighbor MLAG-IPv4-UNDERLAY-PEER remote-as 65102
   neighbor MLAG-IPv4-UNDERLAY-PEER next-hop-self
   neighbor MLAG-IPv4-UNDERLAY-PEER description leaf3
   neighbor MLAG-IPv4-UNDERLAY-PEER route-map RM-MLAG-PEER-IN in
   neighbor MLAG-IPv4-UNDERLAY-PEER password 7 vnEaG8gMeQf3d3cN6PktXQ==
   neighbor MLAG-IPv4-UNDERLAY-PEER send-community
   neighbor MLAG-IPv4-UNDERLAY-PEER maximum-routes 12000
   neighbor 10.255.251.4 peer group MLAG-IPv4-UNDERLAY-PEER
   neighbor 10.255.251.4 description leaf3
   neighbor 172.31.255.12 peer group IPv4-UNDERLAY-PEERS
   neighbor 172.31.255.12 remote-as 65001
   neighbor 172.31.255.12 description spine1_Ethernet5
   neighbor 172.31.255.14 peer group IPv4-UNDERLAY-PEERS
   neighbor 172.31.255.14 remote-as 65001
   neighbor 172.31.255.14 description spine2_Ethernet5
   neighbor 192.0.255.1 peer group EVPN-OVERLAY-PEERS
   neighbor 192.0.255.1 remote-as 65001
   neighbor 192.0.255.1 description spine1
   neighbor 192.0.255.2 peer group EVPN-OVERLAY-PEERS
   neighbor 192.0.255.2 remote-as 65001
   neighbor 192.0.255.2 description spine2
   redistribute connected route-map RM-CONN-2-BGP
   !
   vlan-aware-bundle Tenant_A_OP_Zone
      rd 192.0.255.6:10
      route-target both 10:10
      redistribute learned
      vlan 110
   !
   vlan-aware-bundle Tenant_A_VMOTION
      rd 192.0.255.6:55160
      route-target both 55160:55160
      redistribute learned
      vlan 160
   !
   address-family evpn
      neighbor EVPN-OVERLAY-PEERS activate
   !
   address-family ipv4
      no neighbor EVPN-OVERLAY-PEERS activate
      neighbor IPv4-UNDERLAY-PEERS activate
      neighbor MLAG-IPv4-UNDERLAY-PEER activate
   !
   vrf Tenant_A_OP_Zone
      rd 192.0.255.6:10
      route-target import evpn 10:10
      route-target export evpn 10:10
      router-id 192.0.255.6
      neighbor 10.255.251.4 peer group MLAG-IPv4-UNDERLAY-PEER
      redistribute connected
!
end
```
## show version

```
Arista cEOSLab
Hardware version: 
Serial number: 5ED87B17FF243D42E36EBBD768C8FA8F
Hardware MAC address: 001c.7354.ef52
System MAC address: 001c.7354.ef52

Software image version: 4.28.3M-28837868.4283M (engineering build)
Architecture: i686
Internal build version: 4.28.3M-28837868.4283M
Internal build ID: 45af8df6-a20d-4e7c-963f-efa9e922ee91
Image format version: 1.0
Image optimization: None

cEOS tools version: 1.1
Kernel version: 5.15.0-53-generic

Uptime: 54 minutes
Total memory: 65561552 kB
Free memory: 54270136 kB
```

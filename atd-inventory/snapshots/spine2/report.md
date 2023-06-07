# spine2 Commands Output

## Table of Contents

- [show lldp neighbors](#show-lldp-neighbors)
- [show ip interface brief](#show-ip-interface-brief)
- [show interfaces description](#show-interfaces-description)
- [show version](#show-version)
- [show running-config](#show-running-config)
## show interfaces description

```
Interface                      Status         Protocol           Description
Et1                            up             up                 
Et2                            up             up                 P2P_LINK_TO_LEAF1_Ethernet3
Et3                            up             up                 P2P_LINK_TO_LEAF2_Ethernet3
Et4                            up             up                 P2P_LINK_TO_LEAF3_Ethernet3
Et5                            up             up                 P2P_LINK_TO_LEAF4_Ethernet3
Et6                            up             up                 
Lo0                            up             up                 EVPN_Overlay_Peering
Ma0                            up             up                 oob_management
```
## show ip interface brief

```
Address
Interface       IP Address           Status     Protocol         MTU    Owner  
--------------- -------------------- ---------- ------------ ---------- -------
Ethernet2       172.31.255.2/31      up         up              1500           
Ethernet3       172.31.255.6/31      up         up              1500           
Ethernet4       172.31.255.10/31     up         up              1500           
Ethernet5       172.31.255.14/31     up         up              1500           
Loopback0       192.0.255.2/32       up         up             65535           
Management0     192.168.0.11/24      up         up              1500
```
## show lldp neighbors

```
Last table change time   : 0:30:59 ago
Number of table inserts  : 13
Number of table deletes  : 0
Number of table drops    : 0
Number of table age-outs : 0

Port          Neighbor Device ID       Neighbor Port ID    TTL
---------- ------------------------ ---------------------- ---
Et1           spine1.atd.lab           Ethernet1           120
Et2           leaf1.atd.lab            Ethernet3           120
Et3           leaf2.atd.lab            Ethernet3           120
Et4           leaf3.atd.lab            Ethernet3           120
Et5           leaf4.atd.lab            Ethernet3           120
Et6           spine1.atd.lab           Ethernet6           120
Ma0           spine1.atd.lab           Management0         120
Ma0           host1.atd.lab            Management0         120
Ma0           host2.atd.lab            Management0         120
Ma0           leaf3.atd.lab            Management0         120
Ma0           leaf2.atd.lab            Management0         120
Ma0           leaf4.atd.lab            Management0         120
Ma0           leaf1.atd.lab            Management0         120
```
## show running-config

```
! Command: show running-config
! device: spine2 (cEOSLab, EOS-4.28.3M-28837868.4283M (engineering build))
!
no aaa root
!
username admin privilege 15 role network-admin nopassword
username ansible privilege 15 role network-admin secret sha512 $6$Dzu11L7yp9j3nCM9$FSptxMPyIL555OMO.ldnjDXgwZmrfMYwHSr0uznE5Qoqvd9a6UdjiFcJUhGLtvXVZR1r.A/iF5aAt50hf/EK4/
username arista privilege 15 role network-admin secret sha512 $6$7WhvEi5Ce5f5Ut3z$Ethmha7rb710RKsaVteusVOuNP1Utfjzse58xxbgiZp4MF0fp7BX5lAw8yBgv/HWCihVomuCSrsJx8wKnJ7Tm1
username tom privilege 15 role network-admin secret sha512 $6$TyWn7NeXe/vBRl1t$S4fEOkPmpTGz7TLHCzDNP8D2UfpO3ciC2MuGmCaFMVF3B7zt9KSnt9yq99y69XBIY1HV/kO4QjOk32yRQOru5.
!
daemon TerminAttr
   exec /usr/bin/TerminAttr -cvaddr=10.73.1.238:9910 -cvauth=token,/tmp/token -cvvrf=default -cvsourceip=192.168.0.11 -cvgnmi -smashexcludes=ale,flexCounter,hardware,kni,pulse,strata -ingestexclude=/Sysdb/cell/1/agent,/Sysdb/cell/2/agent -taillogs
   no shutdown
!
vlan internal order ascending range 1006 1199
!
transceiver qsfp default-mode 4x10G
!
service routing protocols model multi-agent
!
hostname spine2
ip name-server vrf default 8.8.8.8
ip name-server vrf default 192.168.2.1
dns domain atd.lab
!
spanning-tree mode none
!
management api http-commands
   no shutdown
   !
   vrf default
      no shutdown
!
aaa authorization exec default local
!
interface Ethernet1
!
interface Ethernet2
   description P2P_LINK_TO_LEAF1_Ethernet3
   no switchport
   ip address 172.31.255.2/31
!
interface Ethernet3
   description P2P_LINK_TO_LEAF2_Ethernet3
   no switchport
   ip address 172.31.255.6/31
!
interface Ethernet4
   description P2P_LINK_TO_LEAF3_Ethernet3
   no switchport
   ip address 172.31.255.10/31
!
interface Ethernet5
   description P2P_LINK_TO_LEAF4_Ethernet3
   no switchport
   ip address 172.31.255.14/31
!
interface Ethernet6
!
interface Loopback0
   description EVPN_Overlay_Peering
   ip address 192.0.255.2/32
!
interface Management0
   description oob_management
   ip address 192.168.0.11/24
!
ip routing
!
ip prefix-list PL-LOOPBACKS-EVPN-OVERLAY
   seq 10 permit 192.0.255.0/24 eq 32
!
ip route 0.0.0.0/0 192.168.0.1
!
route-map RM-CONN-2-BGP permit 10
   match ip address prefix-list PL-LOOPBACKS-EVPN-OVERLAY
!
router bfd
   multihop interval 1200 min-rx 1200 multiplier 3
!
router bgp 65001
   router-id 192.0.255.2
   no bgp default ipv4-unicast
   distance bgp 20 200 200
   graceful-restart restart-time 300
   graceful-restart
   maximum-paths 4 ecmp 4
   neighbor EVPN-OVERLAY-PEERS peer group
   neighbor EVPN-OVERLAY-PEERS next-hop-unchanged
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
   neighbor 172.31.255.3 peer group IPv4-UNDERLAY-PEERS
   neighbor 172.31.255.3 remote-as 65101
   neighbor 172.31.255.3 description leaf1_Ethernet3
   neighbor 172.31.255.7 peer group IPv4-UNDERLAY-PEERS
   neighbor 172.31.255.7 remote-as 65101
   neighbor 172.31.255.7 description leaf2_Ethernet3
   neighbor 172.31.255.11 peer group IPv4-UNDERLAY-PEERS
   neighbor 172.31.255.11 remote-as 65102
   neighbor 172.31.255.11 description leaf3_Ethernet3
   neighbor 172.31.255.15 peer group IPv4-UNDERLAY-PEERS
   neighbor 172.31.255.15 remote-as 65102
   neighbor 172.31.255.15 description leaf4_Ethernet3
   neighbor 192.0.255.3 peer group EVPN-OVERLAY-PEERS
   neighbor 192.0.255.3 remote-as 65101
   neighbor 192.0.255.3 description leaf1
   neighbor 192.0.255.4 peer group EVPN-OVERLAY-PEERS
   neighbor 192.0.255.4 remote-as 65101
   neighbor 192.0.255.4 description leaf2
   neighbor 192.0.255.5 peer group EVPN-OVERLAY-PEERS
   neighbor 192.0.255.5 remote-as 65102
   neighbor 192.0.255.5 description leaf3
   neighbor 192.0.255.6 peer group EVPN-OVERLAY-PEERS
   neighbor 192.0.255.6 remote-as 65102
   neighbor 192.0.255.6 description leaf4
   redistribute connected route-map RM-CONN-2-BGP
   !
   address-family evpn
      neighbor EVPN-OVERLAY-PEERS activate
   !
   address-family ipv4
      no neighbor EVPN-OVERLAY-PEERS activate
      neighbor IPv4-UNDERLAY-PEERS activate
!
end
```
## show version

```
Arista cEOSLab
Hardware version: 
Serial number: A5AE495736BDC1DBFCC343BCF9AE743A
Hardware MAC address: 001c.735f.39c1
System MAC address: 001c.735f.39c1

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
Free memory: 54116464 kB
```

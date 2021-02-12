kube2:
  bgp_as: 98
  router_id: 10.21.10.100
  hostname: kube2
  vxlan_bridge_mtu: 1350
  guest_agent: True
  networking:
    - name: eth0
      ip: 10.21.10.100
      mask: 255.255.255.0
      gw_dev: True
      gw: 10.21.10.1
      mtu: 1350
  ebgp_peers:
    - p20
    - p21 
  hosts_entries:
    - 10.55.0.20: p20 
    - 10.55.0.43: p43 
    - 10.55.0.11: p11
    - 10.55.0.12: p12
    - 10.55.0.75: p75
    - 10.12.10.7: lm1
    - 10.12.10.1: mikrotik-lisk
    - 10.12.10.3: mikrotik-lisk-cap-ac
    - 10.20.10.100: kube1
    - 10.21.10.101: kube2
  frr:
    bgp_as: 98
    enable_bgp: 'yes'
    enable_ospf: 'no'
    enable_bfd: 'yes'
    evpn:
      peers:
        - name: p20
          ip: 10.21.10.1
  glusterfs:
    peers:
      peer1:
        name: p20
        ip: 10.55.0.20
      peer2:
        name: p21
        ip: 10.55.0.21
  k3s:
    master: False
    peer: 10.20.10.100

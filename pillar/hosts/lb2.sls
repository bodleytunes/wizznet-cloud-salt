lb2:
  bgp_as: 100
  router_id: 10.21.10.254
  hostname: lb2
  vxlan_bridge_mtu: 1350
  guest_agent: True
  networking:
    - name: eth0
      ip: 10.21.10.254
      mask: 255.255.255.0
      gw_dev: True
      gw: 10.21.10.1
      mtu: 1350
    - name: eth1
      ip: 10.0.0.254
      mask: 255.255.255.0
      gw_dev: False
      gw: null
      mtu: 1350
    - name: lo
      ip: 10.169.169.100
      mask: 255.255.255.0
      gw_dev: False
      gw: null
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
  frr:
    bgp_as: 100
    enable_bgp: 'yes'
    enable_ospf: 'no'
    enable_bfd: 'yes'
    advertised_networks:
      - name: loopback
        net: 10.169.169.100
        mask: /32
    evpn:
      bgp_peer_as: 
      peers:
        - name: p21
          ip: 10.21.10.1
          bgp_as: 21
  glusterfs:
    peers:
      peer1:
        name: p21
        ip: 10.55.0.21
      peer2:
        name: p20
        ip: 10.55.0.20


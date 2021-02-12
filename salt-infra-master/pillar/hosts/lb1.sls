lb1:
  bgp_as: 100
  router_id: 10.20.10.253
  hostname: lb1
  vxlan_bridge_mtu: 1350
  guest_agent: True
  networking:
    - name: eth0
      ip: 10.20.10.253
      mask: 255.255.255.0
      gw_dev: True
      gw: 10.20.10.1
      mtu: 1350
    - name: eth1
      ip: 10.0.0.253
      mask: 255.255.255.0
      mtu: 1350
      gw_dev: False
      gw: null
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
      peers:
        - name: p20
          ip: 10.20.10.1
    #    - name: p21
    #      ip: 10.55.0.21
  glusterfs:
    peers:
      peer1:
        name: p20
        ip: 10.55.0.20
      peer2:
        name: p21
        ip: 10.55.0.21


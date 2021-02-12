plex:
  hostname: plex
  bgp_as: 21
  vxlan_bridge_mtu: 1350
  guest_agent: True
  networking:
    - name: eth0
      ip: 10.0.0.10
      mask: 255.255.255.0
      gw_dev: True
      gw: 10.0.0.1
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
    evpn:
      bgp_peer_as: 20
      peers:
        - name: p20
          ip: 10.55.0.20
        - name: p21
          ip: 10.55.0.21


lm2:
  hostname: lm2
  router_id: 10.12.10.10
  public_ip: 10.12.10.10
  zt_ip: 10.55.0.122
  wg_ip: 10.56.0.122
  nb_ip: 10.57.0.122
  bgp_as: 12
  vxlan_bridge_mtu: 1350
  networking:
    - name: eno1
      ip: 10.12.10.10
      mask: 255.255.255.0
      gw_dev: True
      gw: 10.12.10.1
      mtu: 1500
  ebgp_peers:
    - p20
    - p21
    - p43
    - p11
    - p12
    - p75
    - p10 
  hosts_entries:
    - 10.12.10.10: lm2
    - 10.55.0.20: p20
    - 10.55.0.21: p21 
    - 10.55.0.43: p43 
    - 10.55.0.11: p11
    - 10.55.0.12: p12
    - 10.55.0.75: p75
    - 10.12.10.1: mikrotik-lisk
    - 10.12.10.3: mikrotik-lisk-cap-ac
  interface_names:
    upstream: eno1
    upstream_physical: eno1
    lxd0: lxdbr0
    lxd1: lxdbr1
    proxmox: vmbr0
    evpn: evpn0
    zerotier: 'zt*'
    wireguard: 'wg*'
    nebula: nebula0
  interface_networks:
    - name: evpn0
      subnet: 10.0.0.0
      ip: 10.0.0.1
      mask: /24
      vxlan_id: 100
      mtu: 1350
      anycast_mac: 26:13:8e:83:01:00
    - name: evpn1
      subnet: 10.1.1.0
      ip: 10.1.1.1
      mask: /24
      vxlan_id: 101
      mtu: 1350
      anycast_mac: 26:13:8e:83:01:01
    - name: vxlan100
      vxlan_id: 100
      bridge_arp_nd_suppress: 'on' 
      bridge_learning: 'off'
      bridge_multicast_flood: 'off'
      bridge_unicast_flood: 'off'
      mtu: 1350
    - name: vxlan101
      vxlan_id: 101
      bridge_arp_nd_suppress: 'on' 
      bridge_learning: 'off'
      bridge_multicast_flood: 'off'
      bridge_unicast_flood: 'off'
      mtu: 1350
    - name: lxdbr0
      subnet: 10.12.12.0
      ip: 10.12.12.1
      mask: /24
      peer_group_name: rancher-kubernetes
      mtu: 1350
    - name: lxdbr1
      subnet: 10.112.0.0
      ip: 10.112.0.1
      mask: /24
      peer_group_name: rancher-kubernetes
      mtu: 1350
    - name: vmbr0
      subnet: 10.200.10.0
      ip: 10.200.1.1
      mask: /24
      mtu: 1350
  frr:
    enable_bgp: 'yes'
    enable_ospf: 'yes'
    enable_bfd: 'yes'
    evpn:
      bgp_peer_as: 21
      peers:
        - name: p21
          ip: 10.55.0.21
          bgp_peer_as: 21
        - name: p20
          ip: 10.55.0.20
          bgp_peer_as: 20
    zt:
      peers:
        - name: lisk
          ip: 10.55.0.11
          peer_group_name: zt
        - name: plym
          ip: 10.55.0.10
          peer_group_name: zt
        - name: hheath
          ip: 10.55.0.75
          peer_group_name: zt
        - name: hetzcloud42
          ip: 10.55.0.42
          peer_group_name: zt
        - name: hetzcloud43
          ip: 10.55.0.43
          peer_group_name: zt
  fstab:
    s3fs:
      bucket_name: backups-p20
      dir: /mnt/backblaze
  gravity:
    client_token: 'abcxyz'    
  zfs:
    name: zpool1
    disk1: /dev/sdb
    disk2: Null
    dataset_lxd: zpool1/lxd 
    dataset_proxmox: zpool1/proxmox_vm
    dataset_k3s: zpool1/k3s
    dataset_gluster: zpool1/gluster 
    dataset_lizardfs: zpool1/lizardfs
  btrfs0:
    name: btrfs0
    disk1: Null
  k3s:
    k3s_advertise_ip: 10.12.10.10
    k3s_server_ip: null
    k3s_database_server_ip: 10.55.0.43
  zt:
    networks:
      - target: '10.122.0.0/16'
        via: '10.55.0.122'
      - target: '10.12.12.0/24'
        via: '10.55.0.122'


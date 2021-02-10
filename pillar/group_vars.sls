group_vars:
  fqdn_domain: 'wizznet.co.uk'
  zt_network: 17d709436c89081d
  zt_subnet:
    target: '10.55.0.0/24'
  gravity:
    auth_server_address: 10.0.0.10 
    cluster_name: wizznet
  salt_master: 86.29.22.70
  cluster_name: wizcluster
  proxmox:
    proxmox_cluster_master_ip: 10.55.0.20
    proxmox_cluster_master_host: p20
  users:
    jon:
      username: jon
      type: superuser
  pvestorage:
    zfs1:
      nodes:
        - p20
        - p21
  glusterfs:
    gv1:
      name: gv1
      nodes:
        - p20
        - p21
      dir: /gv1
      dataset: zpool1/gluster
  k3s:
    k3s_datastore_endpoint_ip: 10.55.0.42
    

        
    

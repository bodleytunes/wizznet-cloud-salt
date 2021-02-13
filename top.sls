base:
  '*':
    - nano
    - fail2ban
  'p2*':
    - set_hostname_proxmox
    - all_hosts_file
    - ifupdown2
    - minion_control
    - cloud_init_disable
    - networking_file
    - initial_package_installs
    - zerotier_one_stage1
    - zerotier_one_stage2
    - install_proxmox
    - kernel_modules
    - storage_disk_partitioning_zpool
    - lxd_snap
    - lxd_configuration
    - ufw
    - backblaze_s3fs
    - networking_file
    - set_sysctl_conf
    - frr_install
    - frr_configuration
    - users
    - users_visudo
    - users_pve
    - storage_gluster
    - storage_gluster_client
    - storage_samba_shares
    - storage_gluster
    - storage_gluster_client
    - states.lizardfs.lizardfs_server
    - states.lizardfs.lizardfs_client
    - proxmox_storage_config
    - dist_upgrade_non_interactive
    - frr_configuration
  'p20':
    - proxmox_cluster_pre_req
    - proxmox_cluster_create






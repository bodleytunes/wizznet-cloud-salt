include:
  - backblaze_s3fs
  - proxmox_storage_config
  - networking_file
  - set_sysctl_conf
  - dist_upgrade_non_interactive
  - frr_configuration
  - users
  - users_visudo
  - users_pve
  - storage_gluster
  - storage_gluster_client
  - storage_samba_shares
  # if master then do this
  {% if opts.id == "p20" %}
  - proxmox_cluster_pre_req
  - proxmox_cluster_create
  {% endif %}
  - storage_gluster
  - storage_gluster_client
  - dist_upgrade_non_interactive
  - states.lizardfs.lizardfs_server
  - states.lizardfs.lizardfs_client











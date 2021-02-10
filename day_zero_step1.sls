include:
# big_list - initial packages
  - all_hosts_file
  - initial_package_installs
# install proxmox
  - install_proxmox
# reboot and make sure proxmox kernel loaded
  - kernel_modules
# partition disk
  - disk_partitioning_zpool
# install lxd
  - lxd_snap
# teleport ssh replacement
 # - gravity - same as zt nrew re allowing based on waiting for something 
  - zerotier_one
#  - zerotier_one_authorize # needs re-allowing to rely on something finishing first
# install_nftables
  - iptables_rules
#  - frr_configuration
  - backblaze_s3fs 
  - lxd_configuration
  - proxmox_storage_config
# networking
  - networking_file
  - networking_config
# setup users
  - users
  # proxmox clustering
  # glusterfs
  # lizardfs
  # k3s_zfs_requirements
  # k3s
  # FreeIPA Enroll
# setup / force minion to run networking on startup - left till end
  - minion_control

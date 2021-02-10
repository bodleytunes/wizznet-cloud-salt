#!/bin/bash

salt-ssh -i p21 state.apply set_hostname_proxmox
salt-ssh -i p21 state.apply all_hosts_file
salt-key -d p21 -y
salt-ssh -i p21 state.apply minion_control
salt-key -a p21 -y



salt p21 state.apply initial_package_installs
salt p21 state.apply initial_package_installs
salt p21 state.apply install_proxmox
salt p21 system.reboot

echo "rebooting..."
sleep 300

# the rest (highstate)
salt '*' saltutil.sync_modules

salt p21 state.apply zerotier_one_stage1
salt p21 state.apply zerotier_one_stage2


salt p21 state.apply kernel_modules test=false
salt p21 state.apply disk_partitioning_zpool test=false
salt p21 state.apply lxd_snap test=false
salt p21 state.apply lxd_configuration test=false
salt p21 state.apply ufw test=false
salt p21 state.apply backblaze_s3fs test=false
salt p21 state.apply proxmox_storage_config test=false

salt p21 state.apply networking_file test=false
salt p21 state.apply networking_config test=false

salt p21 state.apply frr_configuration test=false

salt p21 state.apply users test=false

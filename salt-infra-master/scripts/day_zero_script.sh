{# steps1 #}
salt-ssh -i {{opts.id}} state.apply set_hostname_proxmox
salt-ssh -i {{opts.id}} state.apply all_hosts_file
salt-key -d -y {{opts.id}}
salt-ssh -i {{opts.id}} state.apply minion_control 
salt-key -a -y {{opts.id}}
   {# delete old salt-key #}
   {# accept key in salt (salt-key -a) #}



{# do this twice #}
   salt {{opts.id}} state.apply initial_package_installs 
   salt {{opts.id}} state.apply initial_package_installs

   salt {{opts.id}} state.apply install_proxmox
{# now REBOOT to load proxmox kernel and ZFS etc #}
salt {{opts.id}} system.reboot
sleep 300
{# steps2 #}
{# Zerotier #}
salt '*' saltutil.sync_modules
salt {{opts.id}} state.apply zerotier_one_stage1
salt {{opts.id}} state.apply zerotier_one_stage2


{# steps3 #}
{# Kernel Modules #}
salt {{opts.id}} state.apply kernel_modules test=false
{# ZFS and disk part #}
salt {{opts.id}} state.apply disk_partitioning_zpool test=false
{# LXD #}
salt {{opts.id}} state.apply lxd_snap test=false
salt {{opts.id}} state.apply lxd_configuration test=false
{# firewall #}
salt {{opts.id}} state.apply ufw test=false
{# backups #}
salt {{opts.id}} state.apply backblaze_s3fs test=false
{# proxmox storage #}
salt {{opts.id}} state.apply proxmox_storage_config test=false

{# networking #}
salt {{opts.id}} state.apply networking_file test=false
salt {{opts.id}} state.apply networking_config test=false

{# FRR Configuration / Evpn VXlan / BGP #}
salt {{opts.id}} state.apply frr_configuration test=false

{# setup users #}
salt {{opts.id}} state.apply users test=false
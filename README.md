# wizznet-cloud-deployment-lab
Jon's testbed (Work in progress) ovh cloud server deployment lab

### Example to deploy to two bare metal OVH servers via ansible and salt from Day0

* Deploys servers from bare metal debian 10 buster (via OVH api)
* Install packages, proxmox etc
* Setup Linux networking and bridges using ifupdown2
* Setup encrypted overlay networking via Zerotier-One
* Custom python salt execution module to setup the zerotier Networking, add networks / routes etc
* Setup inter-host bridge evpn/vxlan overlay via FRR / Free range routing (encapped through Zerotier-one)
* Setup Proxmox cluster
* Kernel Modules
* Disk Partitioning: ZFS zpools and datasets
* LXD system container install via snap / configure lxc related bridges
* UFW firewall and NAT ingress rules#
* Haproxy Load balancers with Anycast Loopbacks advertised into BGP
* S3FS Backups to backblaze
* GlusterFS shared storage for stateful apps/storage in rancher/k3s 
* LizardFS shared storage for plex/media programs
* Users, SSH Keys, login policy
* Terraform and cloud init templates/images to deploy initial VM's in proxmox
* Deploy K3s (lightweight kubernetes)
* Install Rancher on K3s

# Work in progress and very rough around the edges! :) 

#### Day 0 examples:
Using ansible instead of BASH script
### via Ansible -> calling Salt

```
python3 _modules/ovh_module.py
  or via pytest (WIP)
pytest -s -m ovh_install
 
 # ^ wait for install to finish, check in soyoustart GUI/control panel.

 ansible-playbook -i inventory.ini day0_0_deploy.yml --tags p20,p21;
 ansible-playbook -i inventory.ini proxmox_join_cluster.yml --tags join-cluster;
 ansible-playbook proxmox_join_cluster.yml -i inventory.ini --tags create_qnode;
 ansible-playbook day0_1_vm_prereqs.yml -i inventory.ini;
 ansible-playbook -i inventory.ini day0_2_terraform.yml;
 ansible-playbook -i inventory.ini day0_3_vm_configuration.yml --extra-vars "current_host=kube1" ;
 ansible-playbook -i inventory.ini day0_3_vm_configuration.yml --extra-vars "current_host=kube2" ;
 ansible-playbook -i inventory.ini day0_3_vm_configuration.yml --extra-vars "current_host=kube1" --tags users_vm;
 ansible-playbook -i inventory.ini day0_3_vm_configuration.yml --extra-vars "current_host=kube2" --tags users_vm;
 ansible-playbook -i inventory.ini day0_3_vm_configuration.yml --extra-vars "current_host=kube1" --tags networking;
 ansible-playbook -i inventory.ini day0_3_vm_configuration.yml --extra-vars "current_host=kube2" --tags networking;
 ansible-playbook -i inventory.ini day0_3_vm_configuration.yml --extra-vars "current_host=kube1" --tags gluster_client;
 ansible-playbook -i inventory.ini day0_3_vm_configuration.yml --extra-vars "current_host=kube2" --tags gluster_client;
 ansible-playbook -i inventory.ini day0_3_vm_configuration.yml --extra-vars "current_host=kube1" --tags k3s;
 ansible-playbook -i inventory.ini day0_3_vm_configuration.yml --extra-vars "current_host=kube2" --tags k3s;
 ansible-playbook -i inventory.ini day0_3_vm_configuration.yml --extra-vars "current_host=kube1" --tags rancher;
 ```
 
 #### To destroy vm's
 `ansible-playbook -i inventory.ini day0_2_terraform.yml --tags terraform_destroy`

 ### Example to deploy directly via saltstack commands and omit ansible:

 ```
salt-ssh -i -L p20,p21 state.apply set_hostname_proxmox
salt-ssh -i -L p20,p21 state.apply all_hosts_file
salt-key -d p20 -y
salt-key -d p21 -y
salt-ssh -i -L p20,p21 state.apply minion_control
salt-key -a p20 -y
salt-key -a p21 -y



salt p21 state.apply initial_package_installs
salt p21 state.apply install_proxmox
salt p21 system.reboot

echo "rebooting..."
sleep 300

# synchronize custom execution modules to minions
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
 ```

# get ubuntu 20.04 cloud image

{% if opts.id == 'p20' %}
  {% set vm_template_id = '9000' %}
{% elif opts.id == 'p21' %}
  {% set vm_template_id = '9001' %}
{% endif %}

{% set zfs_dataset = salt['pillar.get']('pve_vars:zfs:zfs1')  %}

# Only run the following if the template doesn't already exist
# Check for the template by see if the zfs output contains "base"
# ONLY WORKS WITH CMD.SHELL (PIPES ONLY WORK IN PYTHON SHELL)
{% set template_exists = salt['cmd.shell']('zfs list | grep base-'+vm_template_id+'-disk-0')%}
{% if 'zpool1/proxmox_vm/base-'+vm_template_id+'-disk-0' not in template_exists %}

get_ubuntu_18_04:
  cmd.run:
    - name: |
        curl -L  https://cloud-images.ubuntu.com/bionic/current/bionic-server-cloudimg-amd64.img -o /var/lib/vz/template/iso/bionic-server-cloudimg-amd64.img
    - shell: /bin/bash
    - timeout: 300
    - creates: /var/lib/vz/template/iso/bionic-server-cloudimg-amd64.img

create_instance:
  cmd.run:
    - name: |
        qm create {{ vm_template_id }} -name ubuntu-cloudinit-{{ vm_template_id }} -memory 1024 -net0 virtio,bridge=lxdbr0 -cores 1 -sockets 1

# Only run the import image state if the result of zfs list is empty, otherwise it will keep adding new images incrementing each time
# ONLY WORKS WITH CMD.SHELL (PIPES ONLY WORK IN PYTHON SHELL)
{% set virtio_exists = salt['cmd.shell']('zfs list | grep vm-'+vm_template_id+'-disk-0')%}
{% if 'zpool1/proxmox_vm/vm-'+vm_template_id+'-disk-0' not in virtio_exists %} 

import_image:
  cmd.run:
    - name: |
        qm importdisk {{ vm_template_id }} /var/lib/vz/template/iso/bionic-server-cloudimg-amd64.img {{zfs_dataset.name}} 

{% endif %}

attach_disk:
  cmd.run:
    - name: |
        qm set {{ vm_template_id }} -scsihw virtio-scsi-pci -virtio0 {{zfs_dataset.name}}:vm-{{ vm_template_id }}-disk-0

attach_serial:
  cmd.run:
    - name: |
        qm set {{ vm_template_id }} -serial0 socket

set_bootdisk:
  cmd.run:
    - name: |
        qm set {{ vm_template_id }} -boot c -bootdisk virtio0

set_qemu_agent:
  cmd.run:
    - name: |
        qm set {{ vm_template_id }} -agent 1

set_hotplug:
  cmd.run:
    - name: |
        qm set {{ vm_template_id }} -hotplug disk,network,usb

set_cpus:
  cmd.run:
    - name: |
        qm set {{ vm_template_id }} -vcpus 1

add_vga:
  cmd.run:
    - name: |
        qm set {{ vm_template_id }} -vga qxl

set_cloudinit_drive:
  cmd.run:
    - name: |
        qm set {{ vm_template_id }} -ide2 {{zfs_dataset.name}}:cloudinit
# 8GB
resize_drive:
  cmd.run:
    - name: |
        qm resize {{ vm_template_id }} virtio0 8G


# Convert the VM to the template

template_convert:
  cmd.run:
    - name: |
        qm template {{ vm_template_id }}

{% endif %}
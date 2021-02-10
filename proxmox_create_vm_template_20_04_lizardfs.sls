# get ubuntu 20.04 cloud image

{% if opts.id == 'p20' %}
  {% set vm_template_id = '9007' %}
{% elif opts.id == 'p21' %}
  {% set vm_template_id = '9008' %}
{% endif %}

{% set release_name = "focal" %}
{% set image_name = "ubuntu-20.04-server-cloudimg-amd64.img" %}

{% set lizardfs_volume = "liz1" %}



get_ubuntu_18_04:
  cmd.run:
    - name: |
        curl -L  https://cloud-images.ubuntu.com/releases/{{release_name}}/release/{{image_name}} -o /var/lib/vz/template/iso/{{image_name}}
    - shell: /bin/bash
    - timeout: 300
    - creates: /var/lib/vz/template/iso/{{image_name}}

create_instance:
  cmd.run:
    - name: |
        qm create {{ vm_template_id }} -name ubuntu-cloudinit-{{ vm_template_id }} -memory 1024 -net0 virtio,bridge=lxdbr0 -cores 1 -sockets 1

import_image:
  cmd.run:
    - name: |
        qm importdisk {{ vm_template_id }} /var/lib/vz/template/iso/{{image_name}} {{lizardfs_volume}} 


attach_disk:
  cmd.run:
    - name: |
        qm set {{ vm_template_id }} -scsihw virtio-scsi-pci -virtio0 {{lizardfs_volume}}:vm-{{ vm_template_id }}-disk-0

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
        qm set {{ vm_template_id }} -ide2 {{lizardfs_volume}}:cloudinit
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


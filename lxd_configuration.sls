{% set hostvars = salt['pillar.get'](opts.id) %}
{% set interface_networks = salt['pillar.get'](opts.id+':interface_networks', []) %}

{% for net in interface_networks %}
{% if "lxdbr" in net.name %}
{{ net.name }}:
  cmd.run:
    - name: |
          /snap/bin/lxc network create {{ net.name }} ipv4.address={{ net.ip }}{{ net.mask }} 
    - cwd: /tmp
    - shell: /bin/bash
    - timeout: 300
{% endif %}
{% endfor %}

lxd_create_dummy_bridge:
  cmd.run:
    - name: |
          /snap/bin/lxc launch images:alpine/edge/amd64 alpine1 -s zpool1 -n lxdbr1
          /snap/bin/lxc config set alpine1 boot.autostart=1
    - cwd: /tmp
    - shell: /bin/bash
    - timeout: 300

lxd_configuration:
  cmd.run:
    - name: |
        /snap/bin/lxc storage create {{ hostvars.zfs.name }} zfs source={{ hostvars.zfs.dataset_lxd }}
    - cwd: /tmp
    - shell: /bin/bash
    - timeout: 300
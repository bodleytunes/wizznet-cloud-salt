create_ssh_keys:
  cmd.run:
    - name: ssh-keygen -q -N '' -t ed25519 -f /root/.ssh/id_ed25519
    - runas: root
    - unless: test -f /root/.ssh/id_ed25519
ssh.set_known_host:
  module.run:
    - user: root
    - hostname: {{ salt['pillar.get']('group_vars:proxmox:proxmox_cluster_master_host') }}
    - enc: ed25519













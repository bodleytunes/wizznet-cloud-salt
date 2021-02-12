/etc/pve/storage.cfg:
  file.managed:
    - source: salt://templates/proxmox_storage_config.j2
    - template: jinja
    - create: True


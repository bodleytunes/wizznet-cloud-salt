{% set hostvars = salt['pillar.get'](opts.id) %}





zpool1:
  zpool.present:
    - config:
        import: false
        force: true
    - properties:
        comment: disk partition zpool1
        ashift: '12'
        feature@lz4_compress: enabled
    - filesystem_properties:
        compression: lz4
        atime: on
        relatime: on
    - layout:
      - mirror:
        - {{ hostvars.zfs.disk1 }}
        - {{ hostvars.zfs.disk2 }}
{{ hostvars.zfs.dataset_lxd }}:
  zfs.filesystem_present:
    - create_parent: true
{{ hostvars.zfs.dataset_k3s }}:
  zfs.filesystem_present:
    - create_parent: true
{{ hostvars.zfs.dataset_proxmox }}:
  zfs.filesystem_present:
    - create_parent: true
{{ hostvars.zfs.dataset_gluster }}:
  zfs.filesystem_present:
    - create_parent: true
{{ hostvars.zfs.dataset_lizardfs }}:
  zfs.filesystem_present:
    - create_parent: true

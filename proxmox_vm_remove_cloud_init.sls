

remove_cloud_init:
  cmd.run:
    - name: |
        qm set 104 --ide2 none,media=cdrom

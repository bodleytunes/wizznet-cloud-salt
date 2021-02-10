lxd_core:
  cmd.run:
    - name: snap install core
lxd_snap:
  cmd.run:
    - name: snap install lxd
# symlinks for lxc and lxd
#/snap/bin/lxc:
#  file.symlink:
#    - target: /usr/local/bin/lxc
#/snap/bin/lxd:
#  file.symlink:
#    - target: /usr/local/bin/lxd

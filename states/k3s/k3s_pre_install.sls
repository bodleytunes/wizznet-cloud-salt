make_bigdata_mount_folder:
  file.directory:
    - name: /bigdata
    - makedirs: True

# format bigdata
format_bigdata:
  blockdev.formatted:
    - name: /dev/sdb
    - fs_type: ext4

# mount big disk for containers
mount_bigdata:
  mount.mounted:
    - name: /bigdata
    - device: /dev/sdb
    - fstype: ext4
    - persist: True
    - mkmnt: True
    - opts:
      - defaults

make_rancher_folder:
  file.directory:
    - name: /bigdata/rancher
    - makedirs: True

make_longhorn_folder:
  file.directory:
    - name: /bigdata/longhorn
    - makedirs: True

make_k3s_run_folder:
  file.directory:
    - name: /bigdata/kubelet
    - makedirs: True

make_kubelet_folder:
  file.directory:
    - name: /bigdata/run_k3s
    - makedirs: True

# symlink the rancher folder to the bigdata drive
symlink_rancher_folder:
  file.symlink:
    - name: /var/lib/rancher
    - target: /bigdata/rancher
    

#symlink_longhorn_folder:
#  file.symlink:
#    - name: /var/lib/longhorn
#    - target: /bigdata/longhorn

symlink_run_k3s_folder:
  file.symlink:
    - name: /run/k3s
    - target: /bigdata/run_k3s

#symlink_kubelet_folder:
#  file.symlink:
#    - name: /var/lib/kubelet
#    - target: /bigdata/kubelet
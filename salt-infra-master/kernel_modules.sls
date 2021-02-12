kernel_modules:  
  kmod.present:
    - persist: True
    - mods:
      - vxlan
      - ip_vs
      - tun
      - geneve
      - rbd
      - cephfs
      - vfio
      - vfio_iommu_type1
      - vfio_pci
      - vfio_virqfd
      - 8021q
      - zfs

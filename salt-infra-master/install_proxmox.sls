proxmox-enterprise:
  pkgrepo.absent:
    - name: deb https://enterprise.proxmox.com/debian/pve buster pve-enterprise
/etc/apt/sources.list.d/pve-enterprise.list:
  file.absent:
    - name: /etc/apt/sources.list.d/pve-enterprise.list
pkg.del_repo:
  module.run:
    - repo: "deb https://enterprise.proxmox.com/debian/pve buster pve-enterprise"
#dist_upgrade_start:
#  cmd.run:
#    - name: apt update && apt dist-upgrade -y
proxmox:
  pkgrepo.managed:
    - name: deb http://download.proxmox.com/debian/pve buster pve-no-subscription
    - file: /etc/apt/sources.list.d/pve-install-repo.list
    - dist: buster
    - require_in:
      - pkg: proxmox-ve
    - key_url: http://download.proxmox.com/debian/proxmox-ve-release-6.x.gpg
    - gpgcheck: 1
  pkg.latest:
    - name: proxmox-ve
    - refresh: True
#dist_upgrade_end:
#  cmd.run:
#    - name: apt update && apt dist-upgrade -y
del_repo_again:
  module.run:
    - name: pkg.del_repo
    - repo: "deb https://enterprise.proxmox.com/debian/pve buster pve-enterprise"
# proxmox experimental sdn
#proxmox_sdn:
#  pkg.installed:
#    - pkgs:
#      - libpve-network-perl

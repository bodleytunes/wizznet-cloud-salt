install_nftables:
  pkg.installed:
    - pkgs:
      - nftables
nftables:
  service.running:
    - enable: True
    - reload: True
nftables_configure_legacy:
  cmd.script:
    - source: salt://scripts/nftables.sh
    - user: root

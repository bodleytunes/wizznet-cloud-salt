ifupdown2:
  cmd.script:
    - source: salt://scripts/install_ifupdown2.sh
    - user: root

include:
  - dist_upgrade_non_interactive

big_list:
  pkg.installed:
    - pkgs:
      - curl
      - sudo
      - nano
      - ufw
      - iftop 
      - iperf3
      - fail2ban
      - molly-guard
      - htop
      - snap
      - conntrack
      - git
      - ifstat
      - iptraf-ng
      - lzop
      - mbuffer
      - pigz 
      - ncdu
      - tree
      - samba
      - cifs-utils
      - mtr-tiny
      - dnsutils
      - mosh
      - frr
      - libpam-google-authenticator
      - cpu-checker
      - snapd 
      - snap 
      - nethogs
      - pv
      - debhelper
      - python3-pip
      - bridge-utils
      - tcpdump
      - parted
      - pkg-config
      - python-pip
      - openvswitch-switch
big_list_not_installed:
  pkg.purged:
    - pkgs:
      - iptables-persistent
netifaces:
  pip.installed:
    - name: netifaces
python_dev:
  pip.installed:
    - name: python-dev



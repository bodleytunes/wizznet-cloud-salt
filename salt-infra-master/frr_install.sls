{% set deb_ver = salt['grains.get']('lsb_distrib_codename')  %}
{% set frr_version = salt['pillar.get']('frr:version')  %}

purge_frr:
  pkg.purged:
    - name: frr

add_frr_repo:
  pkgrepo.managed:
    - name: deb https://deb.frrouting.org/frr {{ deb_ver }} {{ frr_version }} 
    - file: /etc/apt/sources.list.d/frr.list
    - key_url: https://deb.frrouting.org/frr/keys.asc

frr_install:
  pkg.installed:
    - pkgs:
      - frr
      - frr-pythontools
      - frr-snmp
      - frr-rpki-rtrlib      
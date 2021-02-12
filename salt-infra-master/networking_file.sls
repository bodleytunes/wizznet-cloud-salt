include:
  - cloud_init_disable
  - iptables_legacy
/etc/network/interfaces:
  file.managed:
    - source: salt://templates/networking_config_file.j2
    - template: jinja
#networking:
#  service.running:
#    - name: 
#    - enable: True
#    - reload: True
#    - watch:
#      - file: /etc/network/interfaces


/etc/frr/frr.conf:
  file.managed:
    - source: salt://templates/frr_config.j2
    - user: root
    - group: root
    - mod: 644
    - template: jinja
    - debug: true
/etc/frr/daemons:
  file.managed:
    - source: salt://templates/frr_daemons.j2
    - user: root
    - group: root
    - mod: 644
    - template: jinja
    - debug: true
frr:
  service.running:
    - enable: True
    - reload: True
    - watch:
      - file: /etc/frr/frr.conf
      - file: /etc/frr/daemons  

Setup teleport SystemD service:
  file.copy:
    - name: /etc/systemd/system/teleport.service
    - source: /opt/teleport/teleport/examples/systemd/teleport.service
    - user: root
    - group: root
    - mode: 0440
    - force: True

/etc/teleport.yaml:
  file.managed:
    - source: salt://templates/teleport_node.j2
    - user: root
    - group: root
    - mod: 644

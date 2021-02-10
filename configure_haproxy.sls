


configure_haproxy:
  file.managed:
    - name: /gv1/haproxy/docker/config/etc/haproxy/haproxy.cfg
    - source: salt://templates/haproxy/haproxy.cfg
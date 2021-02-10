haproxy:
  frontend:
    - name: plex
      type: tcp
      port: 32400
  backend:
    - name: plex
      port: 32400
      check: True
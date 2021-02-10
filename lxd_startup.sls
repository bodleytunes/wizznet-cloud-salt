# to force bridge creation even if no containers are started.
lxd_network_startup:
  cmd.run:
    - name: |
        /snap/bin/lxc network list
    - cwd: /tmp
    - shell: /bin/bash
    - timeout: 300
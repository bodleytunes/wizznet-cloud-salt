include:
  - lxd_snap
  
jon:
  user.present:
    - fullname: Jon Clayton
    - password: {{ salt['pillar.get']('secrets:jon') }}
    - shell: /bin/bash
    - home: /home/jon
    - groups:
      - sudo
      - lxd
    - require:
      - sls: lxd_snap
  ssh_auth.present:
    - user: jon
    - enc: ed25519
    - config: '%h/.ssh/authorized_keys'
    - names: 
      - AAAAC3NzaC1lZDI1NTE5AAAAIBNPXegfN6YaATTyrq9ow5didiMvG+CjOEzmK6+vWomH
      - AAAAC3NzaC1lZDI1NTE5AAAAIJjM78UyIQWNbMsca2qafeshPflijH8HbbsKuTTZqB1F
      - AAAAC3NzaC1lZDI1NTE5AAAAIJpASWQUj+UkSv2M4kgxMEeM3oUYtKI54N1CVnwKrk9A
root:
  user.present:
    - password: {{ salt['pillar.get']('secrets:root') }}
    - shell: /bin/bash
    - home: /root
    - groups:
      - sudo
  ssh_auth.present:
    - user: root
    - enc: ed25519
    - config: '/root/.ssh/authorized_keys'
    - names: 
      - AAAAC3NzaC1lZDI1NTE5AAAAIBNPXegfN6YaATTyrq9ow5didiMvG+CjOEzmK6+vWomH
      - AAAAC3NzaC1lZDI1NTE5AAAAIJjM78UyIQWNbMsca2qafeshPflijH8HbbsKuTTZqB1F
      - AAAAC3NzaC1lZDI1NTE5AAAAIJpASWQUj+UkSv2M4kgxMEeM3oUYtKI54N1CVnwKrk9A



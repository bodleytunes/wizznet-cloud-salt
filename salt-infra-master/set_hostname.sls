{% set public_ip = salt['cmd.run']('wget -qO- http://ifconfig.me') %}

set_hostname:
  network.system:
    - enabled: True # only neccessary as a bypass for https://github.com/saltstack/salt/issues/6922
    - hostname: '{{opts.id}}'
    - apply_hostname: True
    - retain_settings: True
hostname_ctl:
  cmd.run:
    - name: hostnamectl set-hostname {{opts.id}}
    - name: hostname {{opts.id}}
#internet_facing_address:
#  host.only:
#    - name: '{{ public_ip }}'
#    - hostnames: {{opts.id}}    
#127.0.1.1:
#  host.only:
#    - hostnames:
#      - {{opts.id}}
#127.0.0.1:
#  host.only:
#    - hostnames:
#      - {{opts.id}}


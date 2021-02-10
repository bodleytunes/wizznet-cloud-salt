base:
  '*':
    - hosts.p20
    - hosts.p21
    - hosts.lm2
    - hosts.plex
    - hosts.lb1
    - hosts.lb2
    - hosts.kube1
    - hosts.kube2
    - hosts.kube3
    - group_vars
    - secrets
    - pve_vars
    - virtual_machines
    - containers
    - k3s
    - frr
  'plex':
    - docker_plex
  'lb1':
    - docker_lb
  'lb2':
    - docker_lb
  'p20':
    - lizardfs
  'p21':
    - lizardfs
  'hosts.lb*':
    - haproxy

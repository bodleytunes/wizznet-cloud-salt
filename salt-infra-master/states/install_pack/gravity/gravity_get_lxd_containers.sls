{% set container_list = salt['cmd.shell']('salt p66 lxd.container_list true') %}
#salt p66 lxd.container_state web1
get_containers:
  cmd.run:
    - name: "salt p66 lxd.container_state web1"
#  cmd.run: 
#    - name: "echo {{ container_list }}"

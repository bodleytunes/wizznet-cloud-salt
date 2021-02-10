
{% set hostvars = salt['pillar.get'](opts.id) %}
{% set groupvars = salt['pillar.get']('group_vars') %}

# zt global network id
{% set zt_network_id = groupvars.zt_network %}
# zt api access token
{% set token =  salt['pillar.get']('secrets:zt_controller_token') %}

{% set script_final_line = "'{\"config\": {\"ipAssignments\": [\"" + hostvars.zt_ip +"\"]} }'" %}
{% set token_local = salt['zt_module.get_auth_token']() %}

{% set zerotier_status =  salt['zt_module.get_node_id'](token=token_local.token) %}



zt_module.set_ip:
  module.run:
  # variables / params / args
    - token: {{token}}
    - zt_network_id: {{zt_network_id}}
    - zt_node_id: {{zerotier_status.address}}
    - ip_address: {{hostvars.zt_ip}}

zt_module.set_name:
  module.run:
  # variables / params / args
    - token: {{token}}
    - zt_network_id: {{zt_network_id}}
    - zt_node_id: {{zerotier_status.address}}
    - zt_name: {{opts.id}}

zt_module.set_description:
  module.run:
  # variables / params / args
    - token: {{token}}
    - zt_network_id: {{zt_network_id}}
    - zt_node_id: {{zerotier_status.address}}
    - description: {{opts.id}}

#zerotier_one_set_ip:
#  cmd.script:
#    - name: salt://scripts/zerotier_one_set_ip.sh
#    - template: jinja
#    # Pass script usable variables in via context dictionary
#    - context:
#        zt_network_id: {{zt_network_id}}
#        zt_member_id: {{ zerotier_status.address }}
#        token: {{token}}
#        script_final_line: {{script_final_line}}
#    - onlyif:
#      - zerotier-cli
#    - require:
#      - sls: zerotier_one_install
#      - sls: zerotier_one_configure



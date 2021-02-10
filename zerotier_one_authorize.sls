{% set groupvars = salt['pillar.get']('group_vars')  %}

# zt global network id
{% set zt_network_id = groupvars.zt_network %}
# zt api access token
#! todo write exec module to get the remote controller token
#TODO

{# set token = 'VN__656______________' #}
{% set token = salt['pillar.get']('secrets:zt_controller_token') %}

{% set script_final_line = "'{\"config\": {\"authorized\": true} }'" %}
# get local auth token for the below module
{% set token_local = salt['zt_module.get_auth_token']() %}

# use my own custom execution module to make the local curl api call to ZT to retreive the node id
{% set zerotier_status =  salt['zt_module.get_node_id'](token=token_local.token) %}

zt_module.set_authorize_node:
  module.run:
    - token: {{token}}
    - zt_network_id: {{zt_network_id}}
    - zt_node_id: {{zerotier_status.address}}
    # has to be boolean not a string!
    - authorize: True
    #- authorize: False


#zerotier_one_authorize:
#  cmd.script:
#    - name: salt://scripts/zerotier_one_authorize.sh
#    - template: jinja
    # Pass script usable variables in via context dictionary
#    - context:
#        zt_network_id: {{zt_network_id}}
#        zt_member_id: {{ zerotier_status.address }}
#        token: {{token}}
#        script_final_line: {{script_final_line}}
  #  - onlyif:
   #   - zerotier-cli
  #  - require:
  #    - sls: zerotier_one_install
  #    - sls: zerotier_one_join



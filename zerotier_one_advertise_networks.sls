# set hostvars
{% set hostvars = salt['pillar.get'](opts.id)  %}
{% set group_vars = salt['pillar.get']('group_vars')  %}

{% set token = salt['pillar.get']('secrets:zt_controller_token') %}


# get local auth token for the below module
{% set token_local = salt['zt_module.get_auth_token']() %}

# use my own custom execution module to make the local curl api call to ZT to retreive the node id
{% set zerotier_status =  salt['zt_module.get_node_id'](token=token_local.token) %}

zt_module.set_networks:
  module.run:
    - token: {{ token }}
    - zt_network_id: {{ salt['pillar.get']('group_vars:zt_network') }}
    - zt_node_id: {{zerotier_status.address}}
    # send list / array of networks
    - networks: {{hostvars.zt.networks}}
    - zt_subnet: {{group_vars.zt_subnet}}





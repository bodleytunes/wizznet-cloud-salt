create_cluster:
  cmd.script:
    - name: salt://scripts/proxmox_cluster_create.sh
    - template: jinja
    - context:
        cluster_name: {{ salt['pillar.get']('group_vars:cluster_name') }}
        link_ip: {{ salt['pillar.get']('group_vars:proxmox:proxmox_cluster_master_ip')  }}

{#  cmd.script: #}
{#    - name: salt://scripts/zerotier_one_authorize.sh #}
{#    - template: jinja #}
{# Pass script usable variables in via context dictionary #}
{#    - context: #} 
{#        zt_network_id: {{zt_network_id}} #}
{#        zt_member_id: {{ zerotier_status.address }} #}
{#        token: {{token}} #}
{#        script_final_line: {{script_final_line}} #}

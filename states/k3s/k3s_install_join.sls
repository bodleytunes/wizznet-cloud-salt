install_openiscsi:
  pkg.installed:
    - pkgs:
      - open-iscsi

#swap off
set_swapoff:
  cmd.run:
    - name: |
        swapoff -a

k3s_join_embedded:
 cmd.script:
    - name: salt://scripts/k3s/join_embedded.sh
    - template: jinja
    - context:
        K3S_TOKEN: {{ salt['pillar.get']('secrets:k3s_token') }}
        SERVER_IP: {{ salt['pillar.get'](opts.id+':k3s:peer') }}
        NODE_IP: {{ salt['pillar.get'](opts.id+':networking:0:ip') }}
        K3S_VERSION: {{ salt['pillar.get']('k3s:k3s_version') }}


#k3s_master:
#  cmd.script:
#    - name: salt://scripts/k3s/create_master.sh
#    - template: jinja
#    - context:
#        K3S_TOKEN: {{ salt['pillar.get']('secrets:k3s_token') }}
#        K3S_POSTGRES_PASSWORD: {{ salt['pillar.get']('secrets:K3S_POSTGRES_PASSWORD')  }}
#        DATASTORE_ENDPOINT_IP: {{ salt['pillar.get']('group_vars:k3s:k3s_datastore_endpoint_ip')  }}
#        NODE_IP: {{ salt['pillar.get'](opts.id+':networking:0:ip') }}




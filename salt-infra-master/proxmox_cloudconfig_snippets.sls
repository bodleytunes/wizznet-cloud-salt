cloud_config_user:
  file.managed:
    - name: /var/lib/vz/snippets/user-data-cicustom.yaml
    # variables (contexts)
    #- context: 
    #    passwd_s3fs: {{  salt['pillar.get']('secrets:backblaze_secret') }}
    - user: root
    - group: root
    - replace: True
    - template: jinja
    - source: salt://templates/user-data-cicustom.yaml

cloud_config_network:
  file.managed:
    - name: /var/lib/vz/snippets/network-data-cicustom.yaml
    # variables (contexts)
    #- context: 
    #    passwd_s3fs: {{  salt['pillar.get']('secrets:backblaze_secret') }}
    - user: root
    - group: root
    - replace: True
    - template: jinja
    - source: salt://templates/network-data-cicustom.yaml
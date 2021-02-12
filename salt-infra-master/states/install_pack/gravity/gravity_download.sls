{% set source_hash = salt['cmd.shell']('echo "md5=`curl -s "https://get.gravitational.com/teleport-v5.0.0-linux-amd64-bin.tar.gz" | md5sum | cut -c -32`"') %}

download-gravity:
  file.managed:
    - name: /tmp/teleport-v5.0.0-linux-amd64-bin.tar.gz
    - source: https://get.gravitational.com/teleport-v5.0.0-linux-amd64-bin.tar.gz
    - source_hash: {{ source_hash }}

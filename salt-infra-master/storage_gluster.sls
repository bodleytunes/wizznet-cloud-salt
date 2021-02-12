{% set DEBID = salt['grains.get']('lsb_distrib_id')  %}
{% set DEBARCH = salt['grains.get']('osarch')  %}
{% set DEBVER = salt['grains.get']('lsb_distrib_codename')  %}

{% set hostvars = salt['pillar.get'](opts.id)  %}




gluster_sources_apt:
  pkgrepo.managed:
    - name: deb https://download.gluster.org/pub/gluster/glusterfs/LATEST/Debian/{{DEBVER}}/{{DEBARCH}}/apt {{DEBVER}} main
    - file: /etc/apt/sources.list.d/gluster.list
    - dist: buster
    - require_in:
      - pkg: glusterfs-server
    - key_url: https://download.gluster.org/pub/gluster/glusterfs/8/rsa.pub
    - gpgcheck: 1
  pkg.latest:
    - name: glusterfs-server
    - refresh: True

{# setup systemd service #}

gluster_service:
  service.running:
    - name: glusterd
    - enable: True
    - reload: True

{# setup gluster peers #}
{% for item in hostvars.frr.evpn.peers %}

gluster_peer_probe:
  cmd.run:
    - name: |
        gluster peer probe {{ item.name }}
{% endfor %}

gluster_create_volume_gv1:
  cmd.run:
    - name: |
        gluster volume create gv1 replica 2 p20:/{{ hostvars.zfs.dataset_gluster }} p21:/{{ hostvars.zfs.dataset_gluster }} force

gluster_start_volume_gv1:
  cmd.run:
    - name: |
        gluster volume start gv1
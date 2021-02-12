{% set plex_version = '1.21.1.3876-3c3adfcb4' %}
{% set os_version = salt['grains.get']('lsb_distrib_id') %}
{% set arch = salt['grains.get']('osarch') %}

# install qemu-guest-agent
guest_agent:
  pkg.installed:
    - pkgs:
      - qemu-guest-agent

plex_download:
  cmd.run:
    - name: curl -L 'https://downloads.plex.tv/plex-media-server-new/{{plex_version}}/debian/plexmediaserver_{{plex_version}}_{{arch}}.deb' -o /tmp/plex_{{plex_version}}.deb
    - creates: /tmp/plex_{{plex_version}}.deb

plex_install:
  pkg.installed:
    - sources:
      - plex_{{plex_version}}: '/tmp/plex_{{plex_version}}.deb'
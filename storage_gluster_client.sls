{% set DEBID = salt['grains.get']('lsb_distrib_id')  %}
{% set DEBARCH = salt['grains.get']('osarch')  %}
{% set DEBVER = salt['grains.get']('lsb_distrib_codename')  %}

{% set hostvars = salt['pillar.get'](opts.id)  %}



 {% if DEBID == "Debian"  %}
gluster_client_sources_apt:
  pkgrepo.managed:
    - name: deb https://download.gluster.org/pub/gluster/glusterfs/LATEST/Debian/{{DEBVER}}/{{DEBARCH}}/apt {{DEBVER}} main
    - file: /etc/apt/sources.list.d/gluster.list
    - dist: buster
    - key_url: https://download.gluster.org/pub/gluster/glusterfs/8/rsa.pub
    - gpgcheck: 1
  pkg.installed:
    - name: glusterfs-client
    - refresh: True
 {% endif %}

 {% if DEBID == "Ubuntu"  %}
gluster_ubuntu_ppa:
  pkgrepo.managed:
    - name: ppa:gluster/glusterfs-8
  pkg.installed:
    - name: glusterfs-client
    - refresh: True
 {% endif %}

/gv1:
  file.directory:
    - makedirs: True


gluster_fstab:
  file.append:
    - name: /etc/fstab
  {% if (opts.id == 'p20') or (opts.id == 'p21')  %}
    - source: salt://templates/p20_fstab_gluster.j2
  {% else %}
    - source: salt://templates/plex_fstab_gluster_client.j2
  {% endif %}
    - template: jinja

mount_command:
  cmd.run:
    - name: "mount -a"


{% if opts.id == "plex"  %}

/gv1/plex/movies:
  file.directory:
    - makedirs: True

/gv1/plex/tv:
  file.directory:
    - makedirs: True

 {% endif %}

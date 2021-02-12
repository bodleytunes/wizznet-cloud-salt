lizardfs_server_apt:
  pkgrepo.managed:
    - name: deb https://dev.lizardfs.com/old-packages/ubuntu/xenial xenial main
    - file: /etc/apt/sources.list.d/lizardfs.list
    - require_in:
      - pkg: lizardfs-master
    - key_url: http://dev.lizardfs.com/old-packages/lizardfs.key
    - gpgcheck: 1
  pkg.latest:
    - name: lizardfs-master
    - refresh: True

lizardfs_install:
  pkg.installed:
    - pkgs:
      - lizardfs-chunkserver
      - lizardfs-client
      - lizardfs-adm
      - lizardfs-cgi
      - lizardfs-cgiserv
      - lizardfs-metalogger 

lizardfs-master:
  service.running:
    - enable: True

lizardfs-chunkserver:
  service.running:
    - enable: True

lizardfs-metalogger:
  service.running:
    - enable: True

cgiserv:
  file.managed:
    - name: /etc/default/lizardfs-cgiserv
    - replace: True
    - template: jinja
    - source: salt://templates/lizardfs/lizardfs-cgiserver

mfsmaster_config:
  file.managed:
    - name: /etc/lizardfs/mfsmaster.cfg
    - replace: True
    - template: jinja
    - makedirs: True
    - source: salt://templates/lizardfs/mfsmaster.cfg

chunkserver:
  file.managed:
    - name: /etc/lizardfs/mfschunkserver.cfg
    - replace: True
    - template: jinja
    - makedirs: True
    - source: salt://templates/lizardfs/mfschunkserver.cfg

mfsexports:
  file.managed:
    - name: /etc/lizardfs/mfsexports.cfg
    - replace: True
    - template: jinja
    - makedirs: True
    - source: salt://templates/lizardfs/mfsexports.cfg

mfsgoals:
  file.managed:
    - name: /etc/lizardfs/mfsgoals.cfg
    - replace: True
    - template: jinja
    - makedirs: True
    - source: salt://templates/lizardfs/mfsgoals.cfg

mfshdd:
  file.managed:
    - name: /etc/lizardfs/mfshdd.cfg
    - replace: True
    - template: jinja
    - makedirs: True
    - source: salt://templates/lizardfs/mfshdd.cfg

# create empty metalogger db
create_metalogger_db:
  file.copy:
    - name: /var/lib/lizardfs/metadata.mfs
    - source: /var/lib/lizardfs/metadata.mfs.empty
    - makedirs: True

/zpool1/lizardfs:
  file.directory:
    - user: lizardfs
    - group: lizardfs
    - recurse:
      - user
      - group

lizardfs-master-reload:
  service.running:
    - name: lizardfs-master
    - enable: True
    - reload: True

lizardfs-chunkserver-reload:
  service.running:
    - name: lizardfs-chunkserver
    - enable: True
    - reload: True

lizardfs-metalogger-reload:
  service.running:
    - name: lizardfs-metalogger
    - enable: True
    - reload: True

lizardfs-webserver-reload:
  service.running:
    - name: lizardfs-cgiserv
    - enable: True
    - reload: True

/liz1:
  file.directory:
    - makedirs: True
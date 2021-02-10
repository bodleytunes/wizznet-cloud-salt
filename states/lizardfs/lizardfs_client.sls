lizardfs_apt:
  pkgrepo.managed:
    - name: deb https://dev.lizardfs.com/old-packages/ubuntu/xenial xenial main
    - file: /etc/apt/sources.list.d/lizardfs.list
    - require_in:
      - pkg: lizardfs-client
    - key_url: http://dev.lizardfs.com/old-packages/lizardfs.key
    - gpgcheck: 1
  pkg.latest:
    - name: lizardfs-client
    - refresh: True

liz1_dir_lizardfs_client:
  file.directory:
    - name: /liz1
    - makedirs: True

lizardfs_fstab_client:
  file.append:
    - name: /etc/fstab
    - source: salt://templates/lizardfs/fstab_lizardfs_client.j2
    - template: jinja

mount_command_client:
  cmd.run:
    - name: "mount -a"
del_repo_s3fs:
  module.run:
    - pkg.del_repo:
      - repo: "deb https://enterprise.proxmox.com/debian/pve buster pve-enterprise"

s3fs_install:
  pkg.installed:
    - pkgs:
      - libfuse-dev
      - fuse
      - build-essential
      - libcurl4-openssl-dev
      - libxml2-dev
      - pkg-config
      - libssl-dev 
      - automake
s3fs_git:
  git.cloned:
    - name: https://github.com/s3fs-fuse/s3fs-fuse
    - target: /tmp/s3fs-fuse
install_s3fs:
  cmd.run:
    - name: |
        cd /tmp/s3fs-fuse
        ./autogen.sh
        ./configure
        make
        make install
    - cwd: /tmp
    - shell: /bin/bash
    - timeout: 300
#    - require:
#      - sls: s3fs_install

/usr/local/bin/s3fs:
  file.symlink:
    - target: /usr/bin
/etc/fstab:
  file.append:
    - source: salt://templates/p20_fstab.j2
    - template: jinja
/etc/fuse.conf:
  file.append:
    - text: user_allow_other 

/etc/passwd-s3fs_permissions:
  file.managed:
    - name: /etc/passwd-s3fs
    # variables (contexts)
    - context: 
        passwd_s3fs: {{  salt['pillar.get']('secrets:backblaze_secret') }}
    - mode: 600
    - user: root
    - group: root
    - replace: True
    - template: jinja
    - source: salt://templates/passwd-s3fs.cfg

#/etc/passwd-s3fs:
#  file.append:
#    - text: {{  salt['pillar.get']('secrets:backblaze_secret') }}

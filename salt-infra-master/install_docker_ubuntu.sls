docker-package-dependencies:
  pkg.installed:
    - pkgs:
      - apt-transport-https
      - python-apt
      - iptables
      - ca-certificates

docker-package-repository:
  pkgrepo.managed:
    - name: deb [arch=amd64] https://download.docker.com/linux/ubuntu {{ salt['grains.get']('oscodename') }} stable
    - key_url: https://download.docker.com/linux/ubuntu/gpg


docker-package:
  pkg.installed:
    - name: docker-ce
    - version: latest
    - pkgrepo: docker-package-repository
    - refresh: True
    - require:
      - pkg: docker-package-dependencies
      - pkgrepo: docker-package-repository

# Set Docker Config vis Daemon.json
set_daemon_json:
  file.managed:
    - name: /etc/docker/daemon.json
    - source: salt://templates/daemon.json


docker-service:
  service.running:
    - name: docker
    - enable: True


docker_py_requirements:
  pkg.installed:
    - name: python3-pip
    - onlyif: True


docker-py:
  pip.installed:
    - name: docker
    - reload_modules: true


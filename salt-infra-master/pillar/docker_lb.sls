docker:
  compose:
    ng:
      haproxy:
        image: 'haproxy:latest'
        container_name: 'haproxy'
        com.docker.network.driver.mtu: 1350
        ports:
          - '80:80'
          - '443:443'
          - '32400:32400'
        # read only volume for the below
        volumes:
          - /gv1/haproxy/docker/config/etc/haproxy:/usr/local/etc/haproxy:ro
        restart: unless-stopped
        working_dir: '/gv1/haproxy/docker'
        volume_driver: 'local'
        network_mode: host


docker:
  compose:
    ng:
      sabnzbd-latest:
        image: 'linuxserver/sabnzbd:latest'
        container_name: 'sabnzbd'
        com.docker.network.driver.mtu: 1350
        ports:
          - '8080:8080'
          - '9090:9090'
        environment:
          PGID: '0'
          PUID: '0'
        volumes:
          - /gv1/plex/docker/sabzbd/config:/config
          - /gv1/plex/docker/sabzbd/downloads:/downloads
          - /gv1/plex/movies:/movies
          - /gv1/plex/tv:/tv
          - /gv1_smb/plex/movies:/movies_gv1_smb
        restart: unless-stopped
        working_dir: '/gv1/plex/docker'
        volume_driver: 'local'
        userns_mode: 'host'
      plex:
        image: 'linuxserver/plex:latest'
        container_name: 'plex'
        com.docker.network.driver.mtu: 1350
        ports:
          - '32400:32400'
        environment:
          PGID: '0'
          PUID: '0'
          VERSION: 'docker'
          PLEX_CLAIM: 'claim-xyHSuWWwWi8m-mXMTX4s'
        volumes:
          - /root/plex/config:/config
          - /gv1/plex/movies:/movies
          - /gv1/plex/tv:/tv
          - /gv1_smb/plex/movies:/movies_gv1_smb
        network_mode: host
        restart: unless-stopped
        working_dir: '/gv1/plex/docker'
        volume_driver: 'local'
        userns_mode: 'host'

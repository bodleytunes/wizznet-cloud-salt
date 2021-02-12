docker:
  compose:
    ng:
      nginx-latest:
        # image: 'docker.io/nginx:latest'  ##Fedora
        image: 'nginx:latest'
        container_name: 'nginx-latest'
        links:
          - 'registry-service:registry'
        ports:
          - '80:80'
          - '443:443'
        volumes:
          - /srv/docker-registry/nginx/:/etc/nginx/conf.d
          - /srv/docker-registry/auth/:/etc/nginx/conf.d/auth
          - /srv/docker-registry/certs/:/etc/nginx/conf.d/certs
        working_dir: '/var/www/html'
        volume_driver: 'local'
        userns_mode: 'host'
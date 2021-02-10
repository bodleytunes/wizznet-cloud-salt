{% set metallb_version = "0.9.5"  %}


metallb_install:
  cmd.run:
    - name: |
        kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v{{ metallb_version }}/manifests/namespace.yaml
        kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v{{ metallb_version }}/manifests/metallb.yaml
        kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
        kubectl expose deployment rancher -n cattle-system --type=LoadBalancer --name=rancher-lb --port=443
        

metallb_create_config_file:
  file.managed:
    - name: /root/metallb.yml
    - source: salt://templates/k3s/metallb.yml


metallb_apply_config_file:
  cmd.run:
    - name: kubectl apply -f /root/metallb.yml



{% set cert_mgr_version = "1.1.0"  %}
{% set rancher_hostname = "rancher.wizznet.co.uk"  %}



apt_transport_https:
  pkg.installed:
    - pkgs:
      - apt-transport-https

helm_package_repo:
  pkgrepo.managed:
    - name: deb https://baltocdn.com/helm/stable/debian/ all main
    - file: /etc/apt/sources.list.d/helm-stable-debian.list
    - key_url: https://baltocdn.com/helm/signing.asc

helm_package_install:
  pkg.installed:
    - pkgs:
      - helm

helm_rancher_repo:
  cmd.run:
    - name: |
        helm repo add rancher-stable https://releases.rancher.com/server-charts/stable

kube_create_rancher_namespace:
  cmd.run:
    - name: |
        kubectl create namespace cattle-system

kube_install_jetstack:
  cmd.run:
    - name: |
        kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v{{ cert_mgr_version }}/cert-manager.crds.yaml

kube_certmanager_namespace:
  cmd.run:
    - name: |
        kubectl create namespace cert-manager

helm_jetstack_repo:
  cmd.run:
    - name: |
        helm repo add jetstack https://charts.jetstack.io

helm_repo_update:
  cmd.run:
    - name: |
        helm repo update

helm_install_certmgr:
  cmd.run:
    - env: 
      - KUBECONFIG: /etc/rancher/k3s/k3s.yaml
    - name: |
        helm install   cert-manager jetstack/cert-manager   --namespace cert-manager   --version v{{ cert_mgr_version }}

helm_install_rancher:
  cmd.run:
    - env: 
      - KUBECONFIG: /etc/rancher/k3s/k3s.yaml
    - name: |
        helm install rancher rancher-stable/rancher   --namespace cattle-system   --set hostname={{ rancher_hostname }}

helm_rancher_rollout_status:
  cmd.run:
    - name: |
        kubectl -n cattle-system rollout status deploy/rancher



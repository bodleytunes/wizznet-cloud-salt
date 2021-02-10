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

scheduler_descheduler:
  cmd.run:
    - env: 
      - KUBECONFIG: /etc/rancher/k3s/k3s.yaml
    - name: |
        helm repo add descheduler https://kubernetes-sigs.github.io/descheduler/
        helm repo update
        helm install descheduler --namespace kube-system descheduler/descheduler




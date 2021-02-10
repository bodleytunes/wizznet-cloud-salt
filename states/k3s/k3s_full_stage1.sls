include:
  - states.k3s.k3s_pre_install
{% if 'kube1' in opts.id %}
  - states.k3s.k3s_install
{% else %}
  - states.k3s.k3s_install_join
{% endif %}
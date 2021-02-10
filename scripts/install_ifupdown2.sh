export DEBIAN_FRONTEND=noninteractive && sudo apt install ifupdown2 -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" && systemctl restart networking

#!/usr/bin/env bash

set -eux -o pipefail

# readonly region=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone/ | sed 's/.$//')
readonly infra_dir='/opt/infra'
readonly infra_conf_dir='/etc/infra'

echo "Waiting for cloud-init to finish..."
timeout 300 /bin/bash -c \
  'until stat /var/lib/cloud/instance/boot-finished 2>/dev/null; do echo -n "."; sleep 1; done; echo'

echo "Start time: $(date)"

mkdir -p ${infra_conf_dir} ${infra_dir}/bin

dnf install -yq ansible-core

env

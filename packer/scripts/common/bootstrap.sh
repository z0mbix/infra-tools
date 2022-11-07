#!/usr/bin/env bash

set -eux -o pipefail

declare -r imds_url="http://169.254.169.254"
declare -r region=$(curl -s ${imds_url}/latest/meta-data/placement/availability-zone/ | sed 's/.$//')
declare -r infra_dir='/opt/infra'
declare -r infra_conf_dir='/etc/infra'

echo "waiting for cloud-init to finish..."
timeout 300 /bin/bash -c \
  'until stat /var/lib/cloud/instance/boot-finished 2>/dev/null; do echo -n "."; sleep 1; done; echo'

mkdir -p ${infra_conf_dir} ${infra_dir}/bin

echo "$region" >${infra_conf_dir}/region

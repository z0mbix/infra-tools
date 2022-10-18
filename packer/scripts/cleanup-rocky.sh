#!/usr/bin/env bash

set -eux -o pipefail

dnf -y clean all --enablerepo=\*

find /var/cache -type f -exec rm -rf {} \;
find /var/log/ -name \*.log -exec rm -f {} \;
rm -rf /var/spool/mail/*
rm -rf /var/mail/*
rm -rf /var/lib/cloud/sem/* /var/lib/cloud/instance /var/lib/cloud/instances/*
rm -rf /etc/ssh/*_host_*
rm -rf /tmp/*
echo >/etc/machine-id
rm /var/lib/systemd/random-seed

echo "Build time: $(date)" >/etc/infra/ami.info

#!/usr/bin/env bash

set -eux -o pipefail

apt-get -y autoremove
apt-get -y clean

find /var/cache -type f -exec rm -rf {} \;
find /var/log/ -name \*.log -exec rm -f {} \;
rm -rf /var/log/apt/*
rm -rf /var/spool/mail/*
rm -rf /var/mail/*
rm -rf /var/lib/cloud/sem/* /var/lib/cloud/instance /var/lib/cloud/instances/*
rm -rf /etc/ssh/*_host_*
rm -rf /tmp/*
echo >/var/log/syslog
echo >/etc/machine-id
rm /var/lib/systemd/random-seed

echo "Build time: $(date)" >/opt/b2c2/infra/ami-info.log

#!/usr/bin/env bash

set -eux -o pipefail

apt-get install -y -qq python3-pip
python3 -m pip install --user ansible-core==2.12.3

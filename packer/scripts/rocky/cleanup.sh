#!/usr/bin/env bash

set -eux -o pipefail

dnf -yq clean all --enablerepo=\*

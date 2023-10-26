#!/usr/bin/env bash

set -xe

echo "Installing necessary packages..."
apt-get update
apt-get install -y curl
apt-get install -y jq
apt-get install -y apt-utils
apt-get install -y unzip
apt-get install -y git
apt-get install -y default-jre

#!/usr/bin/env bash

set -xe

unset http_proxy
unset https_proxy

echo "Installing npm & nodejs..."
apt-get install -y build-essential gcc g++ make
apt-get update
curl -sL -k https://deb.nodesource.com/setup_${NODEJS_VERSION} | bash -
apt-get install -y nodejs
npm config set strict-ssl false
npm config set registry ${NPM_REGISTRY}
# npm config set unsafe-perm true
npm config set prefix "/usr/local/"

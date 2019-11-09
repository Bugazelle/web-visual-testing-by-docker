#!/usr/bin/env bash

set -xe

echo "Clear cache..."
npm cache clean --force
chmod -R 777 $HOME/.npm
chmod -R 777 $HOME/.npmrc
apt-get -y clean all
rm -rf /headless/.cache
rm -rf .cache
rm -rf /var/log
rm -rf /tmp/*
rm -rf /var/lib/apt/lists/*

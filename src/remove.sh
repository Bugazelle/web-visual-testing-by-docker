#!/usr/bin/env bash

set -xe

echo "Removing existing chromium, firefox..."
apt-get remove chromium -y
rm -f /usr/bin/chromium-browser
rm -rf /usr/lib/firefox
rm -rf /usr/bin/firefox

echo "Removing apt caches..."
apt autoremove -y
apt clean

echo "Removing other caches and set permission..."
rm -rf ${HOME}/.cache/*

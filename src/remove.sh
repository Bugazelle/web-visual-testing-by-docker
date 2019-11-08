#!/usr/bin/env bash

set -xe

echo "Removing existing chromium..."
apt-get remove -y chromium*
rm -f ~/Desktop/chromium-browser.desktop

echo "Removing existing firefox..."
rm -rf /usr/lib/firefox
rm -f /usr/bin/firefox
rm -f ~/Desktop/firefox.desktop

echo "Removing apt caches..."
apt-get autoremove -y
apt-get clean

echo "Removing other caches and set permission..."
rm -rf ${HOME}/.cache/*

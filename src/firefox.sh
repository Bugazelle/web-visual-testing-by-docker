#!/usr/bin/env bash

set -xe

echo "Installing firefox v${FIREFOX_VERSION}..."
wget -qO- --no-check-certificate --delete-after https://ftp.mozilla.org/pub/mozilla.org/firefox/releases/${FIREFOX_VERSION}/linux-x86_64/en-US/firefox-${FIREFOX_VERSION}.tar.bz2 | tar xj -C /usr/lib
ln -s /usr/lib/firefox/firefox /usr/bin/firefox

wget -qO- --no-check-certificate --delete-after https://github.com/mozilla/geckodriver/releases/download/v${GECKO_VERSION}/geckodriver-v${GECKO_VERSION}-linux64.tar.gz | tar xz -C /usr/local/bin/

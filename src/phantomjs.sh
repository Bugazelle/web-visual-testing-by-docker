#!/usr/bin/env bash

set -xe

echo "Installing phantomjs v${PHANTOMJS_VERSION}..."
mkdir -p /opt/phantomjs
wget -qO- --no-check-certificate --delete-after https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-${PHANTOMJS_VERSION}-linux-x86_64.tar.bz2 | tar -xj --strip-components 1 -C /opt/phantomjs
ln -s /opt/phantomjs/bin/phantomjs /usr/bin/phantomjs

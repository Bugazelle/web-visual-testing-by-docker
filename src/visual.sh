#!/usr/bin/env bash

set -xe

# export http_proxy=http://172.17.0.1:3128
# export https_proxy=http://172.17.0.1:3128

echo "Installing BackstopJS v${BACKSTOPJS_VERSION}..."
npm install -g backstopjs@${BACKSTOPJS_VERSION}

echo "Set chromium to a constant version in backstopjs..."
wget --no-check-certificate https://raw.githubusercontent.com/Bugazelle/chromium-all-old-stable-versions/master/chromium.stable.json
download=$(jq -r ".linux64.\"${CHROMIUM_VERSION}\".download_url" chromium.stable.json)
position=$(jq -r ".linux64.\"${CHROMIUM_VERSION}\".download_position" chromium.stable.json)
echo "download url is: ${download}"
echo "position is: ${position}"
wget --no-check-certificate -O chromium.zip ${download}
puppeteer=/usr/local/lib/node_modules/backstopjs/node_modules/puppeteer
rm -rf ${puppeteer}/.local-chromium/*
mkdir ${puppeteer}/.local-chromium/linux-${position}
unzip chromium.zip -d ${puppeteer}/.local-chromium/linux-${position}
sed -i "s/\"chromium_revision\"\: \"[0-9]\+\"/\"chromium_revision\"\: \"${position}\"/g" ${puppeteer}/package.json
rm -f chromium.zip

echo "Installing Hermione v${HERMIONE_VERSION}..."
npm install -g hermione@${HERMIONE_VERSION}
npm install -g html-reporter@${HTML_REPORTER_VERSION}
npm install -g html-reporter-legacy@npm:html-reporter@${HTML_REPORTER_LEGACY_VERSION}
npm install -g json-reporter@${JSON_REPORTER_VERSION}
npm install -g looks-same@${LOOKS_SAME_VERSION}
npm install -g selenium-standalone@${SELENIUMSTANDALONE_VERSION}
npm install -g chai@${CHAI_VERSION}

echo "Installing Selenium-Server v${SELENIUMSTANDALONE_VERSION}"
cp default-config.js /usr/local/lib/node_modules/selenium-standalone/lib/
cat /usr/local/lib/node_modules/selenium-standalone/lib/default-config.js
selenium-standalone install


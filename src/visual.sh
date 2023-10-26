#!/usr/bin/env bash

set -xe

# export http_proxy=http://172.17.0.1:3128
# export https_proxy=http://172.17.0.1:3128

echo "Installing Hermione v${HERMIONE_VERSION}..."
npm install -g hermione@${HERMIONE_VERSION}
npm install -g html-reporter@${HTML_REPORTER_VERSION}
npm install -g html-reporter-legacy@npm:html-reporter@${HTML_REPORTER_LEGACY_VERSION}
npm install -g json-reporter@${JSON_REPORTER_VERSION}
npm install -g looks-same@${LOOKS_SAME_VERSION}
npm install -g chai@${CHAI_VERSION}

echo "Installing BackstopJS v${BACKSTOPJS_VERSION}..."
wget https://github.com/garris/BackstopJS/archive/refs/tags/v${BACKSTOPJS_VERSION}.zip
unzip v${BACKSTOPJS_VERSION}.zip
rm -f v${BACKSTOPJS_VERSION}.zip
mv BackstopJS-${BACKSTOPJS_VERSION} /usr/local/lib/node_modules/
cd /usr/local/lib/node_modules/BackstopJS-${BACKSTOPJS_VERSION}
#jq --arg var "$PLAYWRIGHT_VERSION" '.dependencies.playwright |= $var' package.json > temp.json && mv temp.json package.json
#jq --arg var "$PUPPTEER_VERSION" '.dependencies.puppeteer |= $var' package.json > temp.json && mv temp.json package.json
npm install -g

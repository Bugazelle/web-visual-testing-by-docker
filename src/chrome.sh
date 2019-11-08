#!/usr/bin/env bash

set -xe

echo "Installing chrome v${CHROME_VERSION}..."

if [ "${CHROME_VERSION}" == "latest" ]; then
    wget --no-check-certificate -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
    echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list
    apt-get update
    apt-get install google-chrome-stable;
else
    wget --no-check-certificate https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_${CHROME_VERSION}_amd64.deb
    dpkg -i google-chrome-stable_${CHROME_VERSION}_amd64.deb || apt -y -f install
    rm google-chrome-stable_${CHROME_VERSION}_amd64.deb;
fi

sed -i 's/\"$@\"/--no-sandbox --ignore-certificate-errors \"$@\"/' /opt/google/chrome/google-chrome

wget --no-check-certificate https://chromedriver.storage.googleapis.com/${CHROMEDRIV_VERSION}/chromedriver_linux64.zip
unzip chromedriver_linux64.zip -d /usr/bin/
rm -f chromedriver_linux64.zip
sed -i 's/\"$@\"/\"$@\" --no-sandbox/' /opt/google/chrome/google-chrome

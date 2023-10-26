#!/usr/bin/env bash

set -xe

echo "Installing chrome v${CHROMIUM_VERSION}..."
wget --no-check-certificate https://raw.githubusercontent.com/Bugazelle/chromium-all-old-stable-versions/master/chromium.stable.json

# Parse the json
download=$(jq -r ".linux64.\"${CHROMIUM_VERSION}\".download_url" chromium.stable.json)
driver_download=$(jq -r ".linux64.\"${CHROMEDRIV_VERSION}\".driver_download_url" chromium.stable.json)
position=$(jq -r ".linux64.\"${CHROMIUM_VERSION}\".download_position" chromium.stable.json)
echo "download url is: ${download}"
echo "position is: ${position}"

# Download
wget --no-check-certificate -O chromium.zip ${download}
unzip -o chromium.zip -d /usr/lib
rm -f chromium.zip

wget --no-check-certificate -O chromium_driver.zip ${driver_download}
unzip chromium_driver.zip
mv chromedriver_linux64/chromedriver /usr/bin/chromedriver
rm -f chromium_driver.zip
rm -rf chromedriver_linux64

# Add $CHROMIUM_FLAGS
sed -i 's/chrome\" \"$@\"/chrome\" $CHROMIUM_FLAGS \"$@\"/' /usr/lib/chrome-linux/chrome-wrapper

# Set to the system
ln -sfn /usr/lib/chrome-linux/chrome-wrapper /usr/bin/chromium-browser
ln -sfn /usr/lib/chrome-linux/chrome-wrapper /usr/bin/chromium
sed -i 's/Icon=chromium/Icon=\/usr\/lib\/chrome-linux\/product_logo_48.png/' $HOME/Desktop/chromium-browser.desktop

echo "Installing Selenium Server v${SELENIUM_SERVER}..."
wget https://github.com/SeleniumHQ/selenium/releases/download/selenium-${SELENIUM_SERVER}/selenium-server-${SELENIUM_SERVER}.jar
mv selenium-server-${SELENIUM_SERVER}.jar /usr/bin/selenium-server.jar

#!/usr/bin/env bash

set -xe

# Install dockerize
wget --no-check-certificate -O dockerize.tar.gz https://github.com/jwilder/dockerize/releases/download/v0.6.1/dockerize-linux-amd64-v0.6.1.tar.gz
tar -zxvf dockerize.tar.gz
chmod +x dockerize
mv dockerize /usr/local/bin/
rm -rf dockerize.tar.gz

# Install cntlm
apt-get install -y cntlm
cp ${HOME}/cntlm.conf.tmpl /etc/cntlm.conf.tmpl
chmod 777 /etc/cntlm.conf.tmpl
chmod 777 /etc
rm -rf /etc/cntlm.conf

# Cntlm entrypoint
mv $HOME/cntlm-run.sh /usr/local/bin/cntlm-run.sh
chmod 755 /usr/local/bin/cntlm-run.sh

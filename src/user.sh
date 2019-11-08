#!/usr/bin/env bash

set -xe

echo "Create a user ${USER} (uid=${USER_ID}) in the group ${USER} (gid=${USER_ID})"
addgroup ${USER} --gid ${USER_ID}
useradd -l -m -d /home/${USER} -u ${USER_ID} -g ${USER_ID} -G ${USER} ${USER}
echo "${USER} ALL=(ALL) NOPASSWD:ALL" | tee -a /etc/sudoers

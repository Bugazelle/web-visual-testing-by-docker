#!/usr/bin/env bash

set -x
set +e

dockerize -template /etc/cntlm.conf.tmpl:/etc/cntlm.conf;
cntlm;
ret_code=$?;

if [ $ret_code == 0 ]; then
    echo "cntlm starts successfully...";
else
    cat /etc/cntlm.conf;
    echo "cntlm failed start, please check the /etc/cntlm.conf as above is expected or not";
fi

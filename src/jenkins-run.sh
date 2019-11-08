#!/usr/bin/env bash

set -x
set +e

# Try to connect the jenkins master
jenkins-agent -url ${JENKINS_MASTER_URL} ${JENKINS_SLAVE_KEY} ${JENKINS_SLAVE_NAME} "$@";
ret_code=$?;
i=1;

# Check connect status
if [ $ret_code == 0 ]; then
    echo "Jenkins slave should be ready...";
else
    echo "Jenkins slave failed to connect with master, status code is $ret_code";
fi

# Reconnect maximum 3 times
while [ $ret_code != 0 ]; do
    echo "Try $i time(s) to reconnect jenkins...";
    sleep 5;
    jenkins-agent -url ${JENKINS_MASTER_URL} ${JENKINS_SLAVE_KEY} ${JENKINS_SLAVE_NAME} "$@";
    ret_code=$?;
    echo Jenkins connect status is $ret_code;
    if [ $ret_code == 0 ]; then
        echo "Jenkins slave should be ready...";
        break;
    fi
    if [ $i -gt 4 ]; then
        echo "Maximum $i tries are exceeded, still failed to connect the jenkins master.
Please check the followings are expected:
JENKINS_MASTER_URL: ${JENKINS_MASTER_URL}
JENKINS_SLAVE_KEY: ${JENKINS_SLAVE_KEY}
JENKINS_SLAVE_NAME: ${JENKINS_SLAVE_NAME}";
        break;
    fi
    i=`expr $i + 1`;
done

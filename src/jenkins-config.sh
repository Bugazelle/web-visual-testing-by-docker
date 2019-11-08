# Forked from: https://github.com/jenkinsci/docker-slave/blob/master/Dockerfile

#!/usr/bin/env bash

set -xe

echo "Config Jenkins..."
mkdir $HOME/JenkinsAgent
cd $HOME/JenkinsAgent

groupadd -g ${JENKINS_USER_ID} ${JENKINS_USER}
useradd -l -c "Jenkins user" -m -d /home/jenkins/ -u ${JENKINS_USER_ID} -g ${JENKINS_USER_ID} ${JENKINS_USER}

echo 'deb http://deb.debian.org/debian stretch-backports main' > /etc/apt/sources.list.d/stretch-backports.list
curl -k "https://pgp.surfnet.nl/pks/lookup?op=get&search=0x7638D0442B90D010" | awk '/^-----BEGIN/ { output = 1 }; output; /^-----END/ { output = 0 }' > 7638D0442B90D010.txt
curl -k "https://pgp.surfnet.nl/pks/lookup?op=get&search=0x04EE7237B7D453EC" | awk '/^-----BEGIN/ { output = 1 }; output; /^-----END/ { output = 0 }' > 04EE7237B7D453EC.txt
apt-key add 7638D0442B90D010.txt
apt-key add 04EE7237B7D453EC.txt
apt-get update
apt-get install -t stretch-backports git-lfs
curl --create-dirs -fsSLo /usr/share/jenkins/agent.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${JENKINS_REMOTE_VERSION}/remoting-${JENKINS_REMOTE_VERSION}.jar
chmod 755 /usr/share/jenkins
chmod 644 /usr/share/jenkins/agent.jar

mkdir /home/jenkins/.jenkins
mkdir -p ${JENKINS_AGENT_WORKDIR}
chown -R jenkins:jenkins /home/jenkins/
chmod -R guo+rwx /home/jenkins/

wget --no-check-certificate https://raw.githubusercontent.com/jenkinsci/docker-jnlp-slave/master/jenkins-agent
mv jenkins-agent /usr/local/bin/jenkins-agent
chmod 755 /usr/local/bin/jenkins-agent

mv $HOME/jenkins-run.sh /usr/local/bin/jenkins-run.sh
chmod 755 /usr/local/bin/jenkins-run.sh

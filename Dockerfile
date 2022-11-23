FROM bugazelle/ubuntu-xfce-vnc:latest

MAINTAINER Wang Cheng (Ken) "463407426@qq.com"

# Set proxy if necessary
# ENV http_proxy=http://172.17.1:3128
# ENV https_proxy=http://172.17.0.1:3128

# Test components
ARG CHROME_VERSION=106.0.5249.61-1
ARG CHROMIUM_VERSION=106.0.5249.61
ARG CHROMEDRIV_VERSION=106.0.5249.61

ARG FIREFOX_VERSION=105.0.3
ARG GECKO_VERSION=0.32.0

ARG BACKSTOPJS_VERSION=6.1.4
ARG HERMIONE_VERSION=5.5.1
ARG HTML_REPORTER_VERSION=9.5.0
ARG JSON_REPORTER_VERSION=0.1.0
ARG LOOKS_SAME_VERSION=8.1.0
ARG SELENIUMSTANDALONE_VERSION=8.2.4
ARG CHAI_VERSION=4.3.7
ARG NODEJS_VERSION=16.x
ARG NPM_REGISTRY=https://registry.npmjs.org/
# ARG NPM_REGISTRY=https://registry.npm.taobao.org/

# System
ARG USER=web-visual-testing
ARG USER_ID=1001

# Jenkins
ARG JENKINS_USER=jenkins
ARG JENKINS_USER_ID=1000
ARG JENKINS_REMOTE_VERSION=4.9

############ 1. Jenkins Environments ############
# JENKINS_MASTER_URL: master url of the jenkins
# JENKINS_SLAVE_KEY: something like: bb23de4d485447d3f8b73aefa268e687d5660dad553eb4534ff2ae369d7849c6
# JENKINS_SLAVE_NAME: jenkins slave name
# JENKINS_AGENT_WORKDIR: jenkins agent home
# 3 Ways to connnect jenkins master, for example:
# 1. Suggested: jenkins-run.sh
# 2. jenkins-agent -url ${JENKINS_MASTER_URL} ${JENKINS_SLAVE_KEY} ${JENKINS_SLAVE_NAME}
# 3. java -jar /usr/share/jenkins/agent.jar -jnlpUrl ${JENKINS_MASTER_URL}/computer/slave1/slave-agent.jnlp -secret ${JENKINS_SLAVE_KEY}

############ 2. CNTLM               ############
# If behind the NTLM proxy, use the CNTLM: https://linux.die.net/man/1/cntlm
# CNTLM_PROXY_DOMAIN: default global
# CNTLM_PROXY_AUTH: default NTLMv2
# CNTLM_PROXY_USER: no default, please see the configuration in cntlm.conf.tmpl
# CNTLM_PROXY_KEY: no default, please see the configuration in cntlm.conf.tmpl. Use "cntlm -u YourUserName -H" to get the key.
# CNTLM_PROXY_SERVER: no default, please see the configuration in cntlm.conf.tmpl. And you could add more proxy server by: CNTLM_PROXY_SERVER_1, CNTLM_PROXY_SERVER_2, CNTLM_PROXY_SERVER_3, CNTLM_PROXY_SERVER_4, CNTLM_PROXY_SERVER_5
# CNTLM_NO_PROXY: no default, please see the configuration in cntlm.conf.tmpl, default: localhost, 127.0.0.*, 10.*, 192.168.*, 172.17.*
# How to run: launch cntlm-run.sh

ENV REFRESHED_AT=2019-11 \
    DEBIAN_FRONTEND=noninteractive \
    JENKINS_MASTER_URL=http://127.0.0.1:8080 \
    JENKINS_SLAVE_KEY=none \
    JENKINS_SLAVE_NAME=none \
    JENKINS_AGENT_WORKDIR=/home/jenkins/agent \
    CNTLM_PROXY_DOMAIN=global \
    CNTLM_PROXY_AUTH=NTLMv2

# Switch back to root user for extend the bugazelle/ubuntu-xfce-vnc:latest
# For more info, please refer to https://github.com/Bugazelle/docker-headless-vnc-container
USER 0

# Copy: Default work directory is $HOME: /headless
ADD src/. $HOME
ADD default-config.js $HOME

## Build
RUN chmod +x *.sh \
    && ./remove.sh \
    && ./user.sh \
    && ./tools.sh \
    && ./firefox.sh \
    && ./chrome.sh \
    && ./npm.sh \
    && ./visual.sh \
    && ./jenkins-config.sh \
    && ./cntlm-config.sh \
    && ./clear.sh

# Change user from root -> ${user}
USER ${USER}

FROM bugazelle/ubuntu-xfce-vnc:latest

MAINTAINER Wang Cheng (Ken) "463407426@qq.com"

# Set proxy if necessary
# ENV http_proxy=http://172.17.1:3128
# ENV https_proxy=http://172.17.0.1:3128

# Test components
ARG CHROME_VERSION=77.0.3865.120-1
ARG CHROMIUM_VERSION=77.0.3865.120
ARG CHROMEDRIV_VERSION=77.0.3865.40
ARG FIREFOX_VERSION=69.0.3
ARG GECKO_VERSION=0.26.0
ARG PHANTOMJS_VERSION=2.1.1
ARG BACKSTOPJS_VERSION=4.3.2
ARG GEMINI_VERSION=7.5.1
ARG HERMIONE_VERSION=2.13.1
ARG HTML_REPORTER_VERSION=5.3.2
ARG HTML_REPORTER_LEGACY_VERSION=3.4.2
ARG JSON_REPORTER_VERSION=2.0.0
ARG LOOKS_SAME_VERSION=7.2.1
ARG SELENIUMSTANDALONE_VERSION=6.16.0
ARG CHAI_VERSION=4.2.0
ARG NODEJS_VERSION=10.x
ARG NPM_REGISTRY=http://registry.npmjs.org/
# ARG NPM_REGISTRY=http://registry.npm.taobao.org/

# System
ARG USER=web-visual-testing
ARG USER_ID=1001

# Jenkins
ARG JENKINS_USER=jenkins
ARG JENKINS_USER_ID=1000
ARG JENKINS_REMOTE_VERSION=3.35

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
    && ./phantomjs.sh \
    && ./firefox.sh \
    && ./chrome.sh \
    && ./npm.sh \
    && ./visual.sh \
    && ./jenkins-config.sh \
    && ./cntlm-config.sh \
    && ./clear.sh

# Change user from root -> ${user}
USER ${USER}

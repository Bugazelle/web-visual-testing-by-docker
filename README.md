# Web Visual Testing by Docker

Pull the docker image from: 

```
docker pull bugazelle/web-visual-testing
```

![](noVNC_Sample.gif)

## Content
- [Support Visual Testing Lib](#support-visual-testing-lib)
- [Highlight: NoVNC, Jenkins, CNTLM](#highlight)
- [How To Run](#how-to-run)
- [System Info](#system-info)
- [Useful Links](#useful-links)

## Support Visual Testing Lib

1. [BackstopJS](https://github.com/garris/BackstopJS)
2. [Hermione](https://github.com/gemini-testing/hermione)

> Chrome/ChromeDriver: 117.0.5938.149/117.0.5938.149, Firefox/Geckodriver: 117.0/0.33.0
> - If you would like to require a certain version of chrome/chromedirver, firefox/geckodriver and selenium server, please raise an issue. I will build the image for you.

## Highlight
1. Support noVNC
   
   Allow you to debug/watch the test running in a more "visual" way at: [http://127.0.0.1:6901/?password=vncpassword](http://127.0.0.1:6901/?password=vncpassword)
   
   For more info about noVNC: [docker-headless-vnc-container](https://github.com/Bugazelle/docker-headless-vnc-container)
     
   **-e VNC_RESOLUTION=1680x950**: set screen resolution to 1680x950
   
   **-p 6901:6901**: map vnc client port
   
   **-p 5901:5901**: map vnc server port
   
   **-v $(pwd):/tmp**: map files from current folder to container /tmp
   
   ```
   docker run \
       -e VNC_RESOLUTION=1680x950 \
       -p 6901:6901 \
       -p 5901:5901 \
       -v $(pwd):/tmp \
       bugazelle/web-visual-testing
   ```
   
2. Support Jenkins

   Run as a jenkins slave/agent. Available environments parameters:
   
   **JENKINS_MASTER_URL**: Master url of the jenkins, default: http://127.0.0.1:8080
   
   **JENKINS_SLAVE_KEY**: Something like: bb23de4d485447d3f8b73aefa268e687d5660dad553eb4534ff2ae369d7849c6
   
   **JENKINS_SLAVE_NAME**: Jenkins slave name
   
   **JENKINS_AGENT_WORKDIR**: Jenkins agent home, default: /home/jenkins
   
   3 Ways to connect jenkins master, for example:
   
   - Suggested: `jenkins-run.sh`
   
   - `jenkins-agent -url ${JENKINS_MASTER_URL} ${JENKINS_SLAVE_KEY} ${JENKINS_SLAVE_NAME}`
   
   - `java -jar /usr/share/jenkins/agent.jar -jnlpUrl ${JENKINS_MASTER_URL}/computer/slave1/slave-agent.jnlp -secret ${JENKINS_SLAVE_KEY}`
   
   ``` 
   docker run \
       -e VNC_RESOLUTION=1680x950 \
       -p 6901:6901 \
       -p 5901:5901 \
       -v $(pwd):/tmp \
       -e JENKINS_MASTER_URL=http://172.17.0.1:8080 \
       -e JENKINS_SLAVE_KEY=1f27b72ec9cf59711788e8de7d1219766381c1ea0406b5f64de3bb6dcd6df913 \
       -e JENKINS_SLAVE_NAME=slave1 \
       bugazelle/web-visual-testing jenkins-run.sh
   ```
   
   If you would like to setup a jenkins ci/cd environment by docker, more info here: [jenkins/README.md](jenkins/README.md)
   
3. Support CNTLM

   If behind the NTLM proxy, use the CNTLM. Get more info here: [https://linux.die.net/man/1/cntlm](https://linux.die.net/man/1/cntlm)
   
   Available environments parameters:
   
   **CNTLM_PROXY_DOMAIN**: default: global
   
   **CNTLM_PROXY_AUTH**: default: NTLMv2
   
   **CNTLM_PROXY_USER**: no default, please see the configuration in cntlm.conf.tmpl
   
   **CNTLM_PROXY_KEY**: no default, please see the configuration in cntlm.conf.tmpl. Use `cntlm -u YourUserName -H` to get the key.
   
   **CNTLM_PROXY_SERVER**: no default, please see the configuration in cntlm.conf.tmpl. And you could add more proxy server by: CNTLM_PROXY_SERVER_1, CNTLM_PROXY_SERVER_2, CNTLM_PROXY_SERVER_3, CNTLM_PROXY_SERVER_4, CNTLM_PROXY_SERVER_5
   
   **CNTLM_NO_PROXY**: please see the configuration in cntlm.conf.tmpl. default: localhost, 127.0.0.*, 10.*, 192.168.*, 172.17.*
   
   **How to run**: `cntlm-run.sh`, then the proxy should be ready at local: [http://127.0.0.1:3128](http://127.0.0.1:3128)
 
   ```
   docker run \
       -e VNC_RESOLUTION=1680x950 \
       -p 6901:6901 \
       -p 5901:5901 \
       -v $(pwd):/tmp \
       -e CNTLM_PROXY_DOMAIN=global \
       -e CNTLM_PROXY_AUTH=NTLMv2 \
       -e CNTLM_PROXY_USER=YourUserName \
       -e CNTLM_PROXY_KEY=YourKey \
       -e CNTLM_PROXY_SERVER=TheProxyServer, like my.proxy:3128 \
       bugazelle/web-visual-testing /bin/bash -c "cntlm-run.sh; \
          export http_proxy=http://127.0.0.1:3128; \
          export https_proxy=http://127.0.0.1:3128; \
          wget --no-check-certificate http://apache.org; "
   ```
   
## How To Run

1. Debug Purpose & Run Step by Step
   
   1) Start Container, and map the current path to container /tmp
   
      > Note: Sometimes the chromedriver, geckdriver running failed at container, add `--privileged -v /dev/shm:/dev/shm --shm-size 2048m` to solve the issue
   
       ``` 
       docker run \
           -e VNC_RESOLUTION=1680x950 \
           -p 6901:6901 \
           -p 5901:5901 \
           -v $(pwd):/tmp \
           --privileged \
           -v /dev/shm:/dev/shm \
           --shm-size 2048m \
           bugazelle/web-visual-testing
       ```
   
   2) Access the [http://localhost:6901/?password=vncpassword/](http://localhost:6901/?password=vncpassword/) to the vnc env.
   
   3) launch "terminal", run the test as bellow.
   
       ``` 
       cd /tmp;
       ls -l;
       cd samples/backstop_puppeteer_init_demo;
       backstop reference;
       ```

2. Run Directly

   ``` 
   docker run \
       -e VNC_RESOLUTION=1680x950 \
       -p 6901:6901 \
       -p 5901:5901 \
       -v $(pwd):/tmp \
       --privileged \
       -v /dev/shm:/dev/shm \
       --shm-size 2048m \
       bugazelle/web-visual-testing \
           /bin/bash -c "cd /tmp/samples/backstop_puppeteer_init_demo; \
           backstop reference;"
    ```

## System Info

1. OS: debian:11

2. Chrome/ChromeDriver: 117.0.5938.149/117.0.5938.149

3. Firefox/Geckodriver: 117.0/0.33.0

4. NodeJS: 18.x

5. BackstopJS: 6.2.2

6. Hermione: 7.1.6

7. HTML Reporter: 9.10.3

8. Json Reporter: 0.1.0

9. Looks Same: 8.2.4

10. Chai: 4.3.10

11. Java: 11.0.20

12. Git: 2.30.2

13. Default User: root

## Useful Links

1. iOS Resolution: [http://iosres.com/](http://iosres.com/)

2. All possible screen size: [https://material.io/devices/](https://material.io/devices/), [http://viewportsizes.com/](http://viewportsizes.com/)

3. Chrome Flags: [https://peter.sh/experiments/chromium-command-line-switches/](https://peter.sh/experiments/chromium-command-line-switches/)

4. Firefox Flags: [http://kb.mozillazine.org/Command_line_arguments](http://kb.mozillazine.org/Command_line_arguments)

5. SmilerJS Flags: [https://docs.slimerjs.org/current/configuration.html](https://docs.slimerjs.org/current/configuration.html)

6. Phantom Flags: [http://phantomjs.org/api/command-line.html](http://phantomjs.org/api/command-line.html)

7. Firefox User Agents: [https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/User-Agent/Firefox](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/User-Agent/Firefox)

8. Chrome User Agents: [https://developer.chrome.com/multidevice/user-agent](https://developer.chrome.com/multidevice/user-agent)

9. Desired Capabilities: [https://github.com/SeleniumHQ/selenium/wiki/DesiredCapabilities](https://github.com/SeleniumHQ/selenium/wiki/DesiredCapabilities)

10. Previous Chrome (RPM Package): [http://orion.lcg.ufrj.br/RPMS/myrpms/google/](http://orion.lcg.ufrj.br/RPMS/myrpms/google/)

11. Previous Chromium: [https://github.com/Bugazelle/chromium-all-old-stable-versions](https://github.com/Bugazelle/chromium-all-old-stable-versions)

12. Previous Firefox: [https://ftp.mozilla.org/pub/mozilla.org/firefox/releases/](https://ftp.mozilla.org/pub/mozilla.org/firefox/releases/)

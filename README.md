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
- [BackstopJS Samples](#backstopjs-samples)
- [Gemini Samples](#gemini-samples)
- [Hermione Samples](#hermione-samples)
- [System Info](#system-info)
- [Useful Links](#useful-links)

## Support Visual Testing Lib

1. [BackstopJS](https://github.com/garris/BackstopJS)
2. [Gemini](https://github.com/gemini-testing/gemini)
3. [Hermione](https://github.com/gemini-testing/hermione)

> Chrome/ChromeDriver: 77.0.3865.120/77.0.3865.40, Firefox/Geckodriver: 69.0.3/0.26.0, Selenium Sever: 3.9.1
> - If you would like to require a certain version of chrome/chromedirver, firefox/geckodriver and selenium server, please raise a issue. I will build the image for you.

## Highlight
1. Support noVNC
   
   Allow you to debug/watch the test running in a more "visual" way at: [http://127.0.0.1:6901/?password=vncpassword](http://127.0.0.1:6901/?password=vncpassword)
   
   For more info about noVNC: [docker-headless-vnc-container](https://github.com/Bugazelle/docker-headless-vnc-container)
     
   **-e VNC_RESOLUTION=1400x900**: set screen resolution to 1400x900
   
   **-p 6901:6901**: map vnc client port
   
   **-p 5901:5901**: map vnc server port
   
   **-v $(pwd):/tmp**: map files from current folder to container /tmp
   
   ```
   docker run \
       -e VNC_RESOLUTION=1400x900 \
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
       -e VNC_RESOLUTION=1400x900 \
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
       -e VNC_RESOLUTION=1400x900 \
       -p 6901:6901 \
       -p 5901:5901 \
       -v $(pwd):/tmp \
       -e CNTLM_PROXY_DOMAIN=global \
       -e CNTLM_PROXY_AUTH=NTLMv2 \
       -e CNTLM_PROXY_USER=YourUserName \
       -e CNTLM_PROXY_KEY=YourKey \
       -e CNTLM_PROXY_SERVER=TheProxyServer, like my.proxy:3128 \
       /bin/bash -c "cntlm-run.sh; \
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
           -e VNC_RESOLUTION=1400x900 \
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
       cd samples/BackstopJS/Chrome/BackstopJS_PuppeteerEngine_SimulateCookie_UserActions;
       backstop reference;
       ```

2. Run Directly

   ``` 
   docker run \
       -e VNC_RESOLUTION=1400x900 \
       -p 6901:6901 \
       -p 5901:5901 \
       -v $(pwd):/tmp \
       --privileged \
       -v /dev/shm:/dev/shm \
       --shm-size 2048m \
       bugazelle/web-visual-testing \
           /bin/bash -c "cd /tmp/samples/BackstopJS/Chrome/BackstopJS_PuppeteerEngine_SimulateCookie_UserActions; \
           backstop reference;"
    ```

## BackstopJS Samples
   
   - [Chrome - Simulate Cookie & User Actions](samples/BackstopJS/Chrome/BackstopJS_PuppeteerEngine_SimulateCookie_UserActions)
   - [Chrome - Simulate Devices](samples/BackstopJS/Chrome/BackstopJS_PuppeteerEngine_SimulateDevices)
   - **Firefox**: Backstop does not support the firefox well, see the [issue-311](https://github.com/garris/BackstopJS/issues/311)

   > Note: PhantomJS is outdated, use chrome-headless, firefox-headless instead 

## Gemini Samples

   - [Chrome - Simulate User Actions](samples/Gemini/Chrome/Gemini_SimulateUserActions)
   - [Chrome - Simulate Devices](samples/Gemini/Chrome/Gemini_SimulateDevices)
   - [Firefox - Simulate User Actions](samples/Gemini/Firefox/Gemini_SimulateUserActions)
   - [Firefox - Simulate Devices](samples/Gemini/Firefox/Gemini_SimulateDevices)
   
   > Note: 
   > 1. PhantomJS is outdated, use chrome-headless, firefox-headless instead 
   > 2. Gemini is not maintained, use Hermione as instead
   > 3. For html reporter, use **html-reporter-legacy**

## Hermione Samples

   - [Chrome - Simulate User Actions](samples/Hermione/Chrome/Hermione_SimulateUserActions)
   - [Chrome - Simulate Devices](samples/Hermione/Chrome/Hermione_SimulateDevices)
   - [Firefox - Simulate User Actions](samples/Hermione/Firefox/Hermione_SimulateUserActions)
   - [Firefox - Simulate Devices](samples/Hermione/Firefox/Hermione_SimulateDevices)

   > Note: 
   > 1. PhantomJS is outdated, use chrome-headless, firefox-headless instead 
   > 2. Get help from: [WebdriverIO API](https://webdriver.io/api.html), [issue-443](https://github.com/gemini-testing/hermione/issues/443), and [Chai Assert](https://www.chaijs.com/api/assert/)

## System Info

1. OS: Ubuntu 18.04

2. Chrome/ChromeDriver: 77.0.3865.120/77.0.3865.40

3. Firefox/Geckodriver: 69.0.3/0.26.0

4. Selenium Server: 3.9.1

5. PhantomJS: 2.1.1

6. NodeJS: 10.x

7. NPM: 6.x

8. BackstopJS: 4.3.2, configured with certain chromium version: 77.0.3865.120

9. Gemini 7.5.1

10. Hermione: 2.13.1

11. HTML Reporter: 5.3.2

12. Json Reporter: 2.0.0

13. Looks Same: 7.2.1

14. Selenium Standalone: 6.16.0

15. Chai: 4.2.0

16. Java: 1.8.0.222

17. Git: 2.17.x

18. Default User: web-visual-testing (with sudo access)


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

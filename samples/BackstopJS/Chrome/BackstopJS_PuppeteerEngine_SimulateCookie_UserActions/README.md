## Backstop - Chrome - Simulate Cookie & User Actions

BackstopJS simulates cookie & user behavior.

> Note: 
> 1. Assume you put the **samples** folder into the current folder
> 2. Already set proxy in backstop.json. You may need to remove/edit it based on your network environment.

1. Create baseline

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

2. Run test

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
               backstop test;"
    ```

3. Approve Test

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
               backstop approve;"
    ```

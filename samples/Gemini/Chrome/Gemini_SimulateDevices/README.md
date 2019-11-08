## Gemini - Chrome - Simulate Devices

Gemini simulates standard WebUI design devices.

> Note: 
> 1. Assume you put the **samples** folder into the current folder
> 2. Already set proxy in .gemini.js. You may need to remove/edit it based on your network environment.

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
               /bin/bash -c "cd /tmp/samples/Gemini/Chrome/Gemini_SimulateDevices; \
               selenium-standalone start & gemini update;"
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
               /bin/bash -c "cd /tmp/samples/Gemini/Chrome/Gemini_SimulateDevices; \
               selenium-standalone start & gemini test;"
    ```

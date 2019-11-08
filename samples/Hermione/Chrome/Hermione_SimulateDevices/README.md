## Hermione - Chrome - Simulate Devices

Hermione simulates standard WebUI design devices.

> Note: 
> 1. Assume you put the **samples** folder into the current folder
> 2. Already set proxy in .hermione.conf.js & docker command. You may need to remove/edit it based on your network environment.

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
               /bin/bash -c "cd /tmp/samples/Hermione/Chrome/Hermione_SimulateDevices; \
               export http_proxy=http://172.17.0.1:3128; \
               export https_proxy=http://172.17.0.1:3128; \
               npm install --save-dev chai; \
               unset http_proxy; \
               unset https_proxy; \
               selenium-standalone start & hermione --update-refs;"
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
               /bin/bash -c "cd /tmp/samples/Hermione/Chrome/Hermione_SimulateDevices; \
               export http_proxy=http://172.17.0.1:3128; \
               export https_proxy=http://172.17.0.1:3128; \
               npm install --save-dev chai; \
               unset http_proxy; \
               unset https_proxy; \
               selenium-standalone start & hermione;"
    ```

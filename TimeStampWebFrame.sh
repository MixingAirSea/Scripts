#!/bin/bash
mkdir -p /home/hmlab/Pictures/`date +%Y/%j`
fswebcam -q -D 1 -S 6 -F 30 -r 1920x1080 -d /dev/video0 /home/hmlab/Pictures/`date +%Y/%j/%H%M%z.jpeg`

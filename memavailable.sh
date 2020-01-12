#!/bin/bash
# Get the currently-available RAM in Kilobytes. And yes, there are other ways...
# Like top -b -n 1 | grep "^KiB Mem" | awk '{print $6}'
# or free -k | grep ^Mem | awk '{print $4}'
# For some Linux flavors, we need to grep for 'memfree' instead of 'memavailable'
# 'memfree' is needed when using original Windows Linux subsystem
# AVAILABLE_MEM=$(cat /proc/meminfo | grep -i memfree | awk '{print $2}')
# This way works on many systems:
AVAILABLE_MEM=$(cat /proc/meminfo | grep -i memavailable | awk '{print $2}')
echo "${AVAILABLE_MEM}K"

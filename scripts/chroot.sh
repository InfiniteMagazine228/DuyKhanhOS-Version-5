#!/bin/bash

apt update

apt install -y \
$(cat /root/core.list) \
$(cat /root/dev.list) \
$(cat /root/desktop.list) \
$(cat /root/live.list)

apt clean

#!/bin/bash

du -ah /var/lib/docker/containers/ | grep -v "/$" | sort -rh | head -60

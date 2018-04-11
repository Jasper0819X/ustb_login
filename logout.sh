#!/usr/bin/env sh
wget --server-response -O - http://202.204.48.66/F.htm 2>&1 | awk '/^  HTTP/{print $2}'

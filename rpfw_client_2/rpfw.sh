#!/bin/sh
exec ssh -v -o ServerAliveInterval=5 -o ServerAliveCountMax=3 -o ExitOnForwardFailure=yes -o TCPKeepAlive=no -N -R 22301:127.0.0.1:22 -i /home/pi/.ssh/id_ed25519 rpfw@rpfw_server

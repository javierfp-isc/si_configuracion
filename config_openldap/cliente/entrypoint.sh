#!/bin/bash

service xrdp restart
service nscd start

#Uso exec para lanzar un proceso independiente de bucle infinito y arranque de systemd
exec /lib/systemd/systemd


#!/bin/bash

service xrdp restart

#Uso exec para lanzar un proceso independiente de bucle infinito y arranque de systemd
exec /lib/systemd/systemd


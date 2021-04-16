#!/bin/bash

#Arranca slapd
[ -f /usr/sbin/slapd ] && /usr/sbin/slapd

#Arranca ssh
service ssh start

#Arranca webmin
[ -f /etc/init.d/webmin ] && /etc/init.d/webmin start

#Uso exec para lanzar un proceso independiente de bucle infinito
exec bash -c "while true;do sleep 10;done"


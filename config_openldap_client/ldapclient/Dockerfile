FROM debian:buster

MAINTAINER javierfp <javierfp@iessanclemente.net>

ENV TERM xterm
ENV PASS=abc123.
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/sbin

LABEL distribucion="Debian 10"
LABEL descripcion="Imagen Debian para cliente de OpenLDAP"
LABEL paquetes="vim, iputils-ping, wget, nano"
LABEL acceso="usuario: root, password: abc123."

#Copiamos el entrypoint.sh al container
COPY entrypoint.sh /usr/bin/entrypoint.sh

#Copiamos el nsswitch.conf al container
COPY nsswitch.conf /etc/nsswitch.conf

#Copiamos el common-session al container
COPY common-session /etc/pam.d/common-session

#Damos permiso al entrypoint y al script
RUN set -x; \
	chmod +x /usr/bin/entrypoint.sh

#Establecemos la password de root
RUN set -x; \
	echo "root:$PASS" | chpasswd

#Instalamos paquetes de utilidades
RUN set -x; \
	apt update && apt install -y vim wget iputils-ping nano

#Instalamos paquetes cliente openldap
#RUN set -x; \
#	apt install -y libnss-ldap libpam-ldap

#Limpiando
RUN set -x; \
	apt clean

#Comando para arrancar ssh y entrar en bucle de espera
ENTRYPOINT ["/usr/bin/entrypoint.sh"]

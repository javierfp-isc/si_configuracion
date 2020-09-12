FROM debian:buster

MAINTAINER javierfp <javierfp@iessanclemente.net>

ENV TERM xterm
ENV PASS=abc123.
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/sbin

LABEL distribucion="Debian 10"
LABEL descripcion="Imagen Debian OpenLDAP server"
LABEL paquetes="vim, iputils-ping, wget, nano slapd ldap-utils"
LABEL acceso="usuario: root, password: abc123."

#Copiamos el entrypoint.sh al container
COPY entrypoint.sh /usr/bin/entrypoint.sh

#Damos permiso al entrypoint y al script
RUN set -x; \
	chmod +x /usr/bin/entrypoint.sh

#Establecemos la password de root
RUN set -x; \
	echo "root:$PASS" | chpasswd

#Instalamos paquetes de utilidades
RUN set -x; \
	apt update && apt install -y vim wget iputils-ping nano 

#Instalamos paquetes openldap
RUN set -x; \
	DEBIAN_FRONTEND=noninteractive apt install -y slapd ldap-utils

#Copiando archivos config y data de slapd
COPY config.ldif /tmp/config.ldif
COPY data.ldif /tmp/data.ldif

#Configurando slapd
RUN set -x; \
	rm -r /etc/ldap/slapd.d/* && \
	slapadd -n 0 -F /etc/ldap/slapd.d -l /tmp/config.ldif && \
	slapadd -n 1 -F /etc/ldap/slapd.d -l /tmp/data.ldif

#Comandos necesarios para poder instalar webmin (aunque no se instala en la imagen, queda listo para ello)
RUN set -x; \
	rm /etc/apt/apt.conf.d/docker-gzip-indexes && \
	apt-get purge apt-show-versions && \
	rm /var/lib/apt/lists/*lz4 && \
	apt-get -o Acquire::GzipIndexes=false update && \
	apt-get install -y apt-show-versions && \
	apt install -y libnet-ldap-perl libconvert-asn1-perl

#Limpiando
RUN set -x; \
	apt clean

#Comando para arrancar ssh y entrar en bucle de espera
ENTRYPOINT ["/usr/bin/entrypoint.sh"]

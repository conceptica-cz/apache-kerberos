FROM ubuntu:jammy
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install -y apache2 apache2-utils \
    libapache2-mod-auth-kerb gettext
RUN apt-get clean

RUN ln -sf /dev/stdout /var/log/apache2/access.log
RUN ln -sf /dev/stderr /var/log/apache2/error.log

RUN a2dissite 000-default.conf
RUN rm /etc/apache2/sites-available/000-default.conf
RUN a2enmod proxy
RUN a2enmod proxy_http
RUN a2enmod headers

WORKDIR /app

COPY run_apache.sh run_apache.sh
RUN chmod +x run_apache.sh

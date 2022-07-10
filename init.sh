#!/usr/bin/env bash

export LOG_LEVEL=${LOG_LEVEL:=info}


cat /app/config/default.conf | envsubst > /etc/apache2/sites-available/default.conf
cp /app/keytab/apache2.keytab /etc/apache2/apache2.keytab

chown www-data:www-data /etc/apache2/apache2.keytab
chmod 400 /etc/apache2/apache2.keytab

a2ensite default

apachectl -D FOREGROUND
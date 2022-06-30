#!/usr/bin/env bash

export LOG_LEVEL=${LOG_LEVEL:=info}

echo "$REALM_IP $REALM_DOMAIN" >> /etc/hosts

cat /etc/apache2/templates/default.conf | envsubst > /etc/apache2/sites-available/default.conf
cp /etc/apache2/templates/apache2.keytab /etc/apache2/apache2.keytab

chown www-data:www-data /etc/apache2/apache2.keytab
chmod 400 /etc/apache2/apache2.keytab

a2ensite default

apachectl -D FOREGROUND
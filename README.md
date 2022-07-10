# Apache2 server with support of Kerberos SSO authentication.

Docker image for apache2 web server with support of Kerberos SSO authentication.


## Configuration

The image reads template configuration file from the `/app/config/default.conf ` directory.
Template file supports environment variables in format `${VARIABLE}`.

Also the image copies the Kerberos keytab file from `/app/keytab/apache2.keytab` to the `/etc/apache2/apache2.keytab` directory.


Here is example of Kerberos SSO of the template configuration file:

```
...
<Location />
    ...
    AuthType Kerberos
    AuthName "Kerberos Login"
    KrbAuthRealm ${KERBEROS_REALM}
    Krb5Keytab /etc/apache2/apache2.keytab
    KrbMethodNegotiate On
    KrbMethodK5Passwd Off
    Require valid-user
    RequestHeader set X-Remote-User expr=%{REMOTE_USER}
</Location>
...
```

## Usage

Here is an example using docker-compose.yml:

```yaml
apache:
image: conceptica/apache_kerberos:latest
volumes:
    - ./apache-config/:/app/config/
    - ./keytab:/app/keytab
ports:
  - "80:80"
env_file: .envs/.development/.apache
```



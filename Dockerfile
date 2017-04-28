FROM alpine:3.4
MAINTAINER Daniel Andrei Minca <mandrei17@gmail.com>
ARG USERNAME=test
ARG PASSWORD=test

# When running this container, map host's content subdir to /var/webdav
# Eg.: docker run <...> -v /path/to/content:/var/webdav

# apache2-utils: Needed for htpasswd program.
RUN set -x \
  && apk -v --no-cache --update add \
    bash \
    apache2 \
    apache2-webdav \
    apache2-utils \

# Create a subdir for webdav lockdb file.
  && mkdir -vp /var/lib/dav \
  && chown apache:apache /var/lib/dav \
  && chmod 755 /var/lib/dav \

# Create a subdir to hold the daemon's pid:
  && mkdir -vp /run/apache2 \

# tune webdav
  && htpasswd -cb /etc/apache2/webdav.password $USERNAME $PASSWORD \
  && chown root:apache /etc/apache2/webdav.password \
  && chmod 640 /etc/apache2/webdav.password

ADD dav.conf /etc/apache2/conf.d/

EXPOSE 80 443

CMD httpd -DFOREGROUND


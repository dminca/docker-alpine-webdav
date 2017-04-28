#!/bin/bash

htpasswd -cb /etc/apache2/webdav.password $USERNAME $PASSWORD
chown root:apache /etc/apache2/webdav.password
chmod 640 /etc/apache2/webdav.password


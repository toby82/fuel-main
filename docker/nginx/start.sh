#!/bin/bash

# Clean rpm locks before puppet run.
# See ticket https://bugs.launchpad.net/fuel/+bug/1339236
rm -f /var/lib/rpm/__db.*
rpm --rebuilddb

#Correct permissions after docker clobbers them on export
chmod -R 755 /var/www/nailgun
chmod -R 755 /var/www/nailgun/* 2>/dev/null
chmod -R 755 /usr/share/nailgun/static 2>/dev/null

puppet apply -v /etc/puppet/modules/nailgun/examples/nginx-only.pp
nginx -g 'daemon off;'

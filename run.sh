#!/bin/bash

DB_HOST=${DB_HOST:-database}
DB_NAME=${DB_NAME:-zabbix}
DB_USER=${DB_USER:-zabbix}
DB_PORT=${DB_PORT:-3306}
DB_PASSWORD=${DB_PASSWORD:-insecure}
DEBUG_LEVEL=${DEBUG_LEVEL:-2}
ZABBIX_HOST=${ZABBIX_HOST:-zabbix}
ZABBIX_PORT=${ZABBIX_PORT:-10051}

# write zabbix frontend config

cat <<EOF > /usr/share/zabbix/conf/zabbix.conf.php
<?php
// Zabbix GUI configuration file.
global \$DB;

\$DB['TYPE']     = 'MYSQL';
\$DB['SERVER']   = '${DB_HOST}';
\$DB['PORT']     = '${DB_PORT}';
\$DB['DATABASE'] = '${DB_NAME}';
\$DB['USER']     = '${DB_USER}';
\$DB['PASSWORD'] = '${DB_PASSWORD}';

// Schema name. Used for IBM DB2 and PostgreSQL.
\$DB['SCHEMA'] = '';

\$ZBX_SERVER      = '${ZABBIX_HOST}';
\$ZBX_SERVER_PORT = '${ZABBIX_PORT}';
\$ZBX_SERVER_NAME = 'Zabbix server';

\$IMAGE_FORMAT_DEFAULT = IMAGE_FORMAT_PNG;
EOF

# ensure correct rights for zabbix config
chmod 640 /usr/share/zabbix/conf/zabbix.conf.php
chown root:www-data /usr/share/zabbix/conf/zabbix.conf.php

# ensure pid file is removed
rm -f /var/run/apache2/apache2.pid

exec /usr/bin/pidproxy /var/run/apache2/apache2.pid /bin/bash -c "source /etc/apache2/envvars && exec /usr/sbin/apache2 -DFOREGROUND"

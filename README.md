# Zabbix 3.0 web interface for MySQL in Docker 

## Environment variables

Name | Default | Required | Description
--- | --- | --- | ---
`DB_HOST` | database | No |  Hostname of database server
`DB_NAME` | zabbix | No |  Name of database
`DB_USER` | zabbix | No |  User for database
`DB_PASSWORD` | insecure | No |  Password for database
`DEBUG_LEVEL` | 2 | No |  Debug level for zabbix daemon
`ZABBIX_HOST` | zabbix | No | Hostname to reach zabbix server
`ZABBIX_PORT` | 10051 | No | Port to reach zabbix server

## Usage

See [docker-zabbix-server](https://github.com/simoswine/docker-zabbix-server)

DB_HOST=${DB_HOST:-database}
DB_NAME=${DB_NAME:-zabbix}
DB_USER=${DB_USER:-zabbix}
DB_PORT=${DB_PORT:-3306}
DB_PASSWORD=${DB_PASSWORD:-insecure}
DEBUG_LEVEL=${DEBUG_LEVEL:-2}
ZABBIX_HOST=${ZABBIX_HOST:-zabbix}
ZABBIX_PORT=${ZABBIX_PORT:-10051}


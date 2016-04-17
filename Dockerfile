FROM debian:jessie

ENV ZABBIX_VERSION 3.0
ENV ZABBIX_FULL_VERSION 1:3.0.1-1+jessie

# Add zabbix repo
COPY zabbix-repo.key /tmp/
RUN echo "deb http://repo.zabbix.com/zabbix/${ZABBIX_VERSION}/debian jessie main"     >  /etc/apt/sources.list.d/zabbix.list && \
    echo "deb-src http://repo.zabbix.com/zabbix/${ZABBIX_VERSION}/debian jessie main" >> /etc/apt/sources.list.d/zabbix.list && \
    apt-key add /tmp/zabbix-repo.key

# install zabbix-server
RUN apt-get update && \
    apt-get -y --no-install-recommends install "zabbix-frontend-php=${ZABBIX_FULL_VERSION}" supervisor


# configure apache server
ADD apache.default.conf /etc/apache2/sites-available/000-default.conf

# removing alias to /zabbix
RUN sed -i '1,5d' /etc/zabbix/apache.conf

# setting timezone
RUN sed -i '/php_value date.timezone/c\    php_value date.timezone Europe/London' /etc/zabbix/apache.conf

EXPOSE 80

ADD run.sh /run.sh
CMD ["/bin/bash", "/run.sh"]

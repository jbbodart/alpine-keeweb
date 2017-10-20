FROM alpine:3.6
MAINTAINER jbbodart <jbbodart@yahoo.com>

ENV WWW_ROOT=/keeweb \
	CONF_PATH=/etc/lighttpd/conf.d \
	START_PATH=/usr/local/bin/start.d

RUN apk add --no-cache lighttpd lighttpd-mod_auth lighttpd-mod_webdav apache2-utils openssl \
	&& rm -rf /var/www/localhost \
	&& mkdir -p $CONF_PATH $START_PATH

# clone keeweb
RUN wget https://github.com/keeweb/keeweb/archive/gh-pages.zip; \
    unzip gh-pages.zip; \
    rm gh-pages.zip; \
    mv keeweb-gh-pages keeweb; \
    rm keeweb/CNAME

# clone keeweb plugins
RUN wget https://github.com/keeweb/keeweb-plugins/archive/master.zip; \
    unzip master.zip; \
    rm master.zip; \
    mv keeweb-plugins-master/docs keeweb/plugins; \
    rm -rf keeweb-plugins-master \
    rm keeweb/plugins/CNAME

COPY 10-basic.conf 20-webdav.conf $CONF_PATH
COPY 20-webdav.sh $START_PATH
COPY run.sh /usr/local/bin

WORKDIR $WWW_ROOT

EXPOSE 80

CMD ["run.sh"]

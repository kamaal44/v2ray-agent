FROM centos
RUN mkdir -p /usr/src/v2ray
RUN yum install wget nginx unzip -y && rm -rf /etc/nginx/nginx.conf \
    && wget -P /usr/src/v2ray/ https://github.com/V2Ray/V2Ray-core/releases/download/v4.21.3/V2Ray-linux-64.zip \
    && unzip -d /usr/src/v2ray/ /usr/src/v2ray/V2Ray-linux-64.zip

COPY ./Docker/config_ws.json /usr/src/v2ray/
COPY ["./Docker/nginx.conf","./Docker/start.sh","/etc/nginx/"]
EXPOSE 80
CMD ["/etc/nginx/start.sh"]

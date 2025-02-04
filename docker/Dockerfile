FROM alpine:edge

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY lip /usr/local/bin/lip
COPY lip.exe /opt/lip/lip.exe

RUN sed -i 's#https\?://dl-cdn.alpinelinux.org/alpine#https://mirrors.tuna.tsinghua.edu.cn/alpine#g' /etc/apk/repositories \
&& apk update \
&& apk add aria2 cabextract wine xvfb-run xvfb \
&& wget -O /usr/local/bin/winetricks https://mirror.ghproxy.com/https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks \
&& chmod +x /usr/local/bin/winetricks \
&& chmod +x /usr/local/bin/entrypoint.sh \
&& chmod +x /usr/local/bin/lip

ENV WINEDEBUG=-all

WORKDIR /root

FROM alpine:latest as base

WORKDIR /tmp/
RUN apt install unzip
ADD https://terraria.org/server/terraria-server-1401.zip /terraria.zip
RUN apk add --update-cache \
    unzip \
    chmod +x /1401/Linux/TerrariaServer \
    chmod +x/1401/Linux/TerrariaServer.bin.x86_64

FROM mono:latest

WORKDIR /home/terraria

COPY --from=base /tmp/1401/Linux/ /home/terraria
COPY config.cfg config.cfg

RUN mkdir world

ENTRYPOINT ["TerrariaServer"]
CMD ["-config ", "config.cfg"]
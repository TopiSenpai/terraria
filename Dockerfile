FROM alpine:latest as base

WORKDIR /tmp/
ADD https://terraria.org/system/dedicated_servers/archives/000/000/036/original/terraria-server-1402.zip terraria.zip
RUN apk add --update-cache \
    unzip
RUN unzip terraria.zip 
RUN chmod +x 1402/Linux/TerrariaServer 
RUN chmod +x 1402/Linux/TerrariaServer.bin.x86_64

FROM mono:latest

WORKDIR /home/terraria

COPY --from=base /tmp/1402/Linux/ /home/terraria
COPY config.cfg config.cfg

RUN mkdir worlds

ENTRYPOINT ["./TerrariaServer"]
CMD ["-config ", "config.cfg"]
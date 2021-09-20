#!/bin/sh
build0=$(buildah from alpine:3)
buildah run "$build0" sh -c "apk add --no-cache -q --update curl \
  libmediainfo \
  gcompat \
  icu \
  sqlite-libs &&\
  mkdir -p /app/prowlarr/bin \
  /config \
  /downloads &&\
  curl -sL 'http://prowlarr.servarr.com/v1/update/develop/updatefile?os=linux&runtime=netcore&arch=x64' | \
  tar xz -C /app/prowlarr/bin --strip-components=1 &&\
  rm -rf /tmp/* app/prowlarr/bin/Prowlarr.Update/ &&\
  apk del -q curl apk-tools &&\
  adduser prowlarr -S -D -u 1321 &&\
  chown -R prowlarr /app/prowlarr \
  /config"
buildah config --entrypoint "/app/prowlarr/bin/Prowlarr -nobrowser -data=/config" \
   --user=prowlarr \
   --workingdir=/config \
   --port 9696/tcp \
   --volume /config,/downloads \
   "$build0"
buildah commit --rm "$build0" prowlarr-alpine-container:latest

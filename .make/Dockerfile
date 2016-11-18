FROM node:7.1-alpine

ENV makedepends "build-base python"

WORKDIR /aglio

RUN apk add --no-cache $makedepends\
 && npm install aglio\
 && apk del --purge $makedepends

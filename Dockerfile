ARG BASE_VERSION=19
FROM node:${BASE_VERSION}-alpine
ARG BASE_VERSION
ENV APP_VERSION=${BASE_VERSION}

RUN apk add --update curl && \ rm -rf /var/cache/apk/*
WORKDIR /usr/app

COPY ./package.json ./
RUN npm install
COPY ./index.js ./

EXPOSE 8080
HEALTHCHECK --interval=10s --timeout=1s \
    CMD curl -f http://localhost:8080/ || exit 1

CMD [ "npm", "start" ]

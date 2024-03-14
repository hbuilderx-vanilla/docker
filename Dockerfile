ARG NODE_VERSION=16.17.1
ARG ALPINE_VERSION=3.18
FROM node:${NODE_VERSION}-alpine AS node
FROM alpine:${ALPINE_VERSION}
ENV API_SERVER_URL=https://github.com/hbuilderx-vanilla/api-server.git

RUN apk update && \
    apk add --no-cache bash unzip wget git && \
    rm -rf /var/cache/apk/*

COPY --from=node /usr/lib /usr/lib
COPY --from=node /usr/local/lib /usr/local/lib
COPY --from=node /usr/local/include /usr/local/include
COPY --from=node /usr/local/bin /usr/local/bin
RUN npm install -g yarn --force

COPY core-3.9.9.zip /opt/
RUN unzip /opt/core-3.9.9.zip -d /opt/ && \
    rm /opt/core-3.9.9.zip && \
    mkdir /projects

COPY core-install.sh /root/
RUN chmod +x /root/core-install.sh

# Need manual run it if minimal version
# RUN /root/core-install.sh

WORKDIR /root
RUN git clone ${API_SERVER_URL} && \
    cd api-server && \
    npm i
EXPOSE 3000
CMD [ "node","/root/api-server/index.js" ]

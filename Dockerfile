ARG NODE_VERSION=16.17.1
ARG ALPINE_VERSION=3.18
FROM node:${NODE_VERSION}-alpine AS node
FROM alpine:${ALPINE_VERSION}
RUN echo "https://mirrors.aliyun.com/alpine/v3.18/main/" > /etc/apk/repositories \
    && echo "https://mirrors.aliyun.com/alpine/v3.18/community/" >> /etc/apk/repositories
RUN apk update && apk add --no-cache bash unzip wget

# Install node-16.17.1
COPY --from=node /usr/lib /usr/lib
COPY --from=node /usr/local/lib /usr/local/lib
COPY --from=node /usr/local/include /usr/local/include
COPY --from=node /usr/local/bin /usr/local/bin
RUN npm install -g yarn --force \ 
    && npm config set registry https://registry.npmmirror.com

# Inject HBuilderX core
COPY core-3.9.5.zip /opt/
RUN unzip /opt/core-3.9.5.zip -d /opt/ \
    && rm /opt/core-3.9.5.zip

# Install HBuilderX core dependencies
COPY core-install.sh /root/
RUN chmod +x /root/core-install.sh && /root/core-install.sh

# Install and start api server

# COPY start.sh /root/
# RUN chmod +x /root/start.sh
# EXPOSE 3000
# CMD ["/root/start.sh"]

ARG NODE_VERSION=18.20.0
ARG ALPINE_VERSION=3.18
FROM node:${NODE_VERSION}-bullseye-slim AS node

RUN apt update && \
    apt install -y bash unzip wget git python3 make g++ && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    npm install -g yarn --force

ARG CORE_VERSION=4.15.0
COPY core-${CORE_VERSION}.tar.gz /opt/

RUN tar -xzf /opt/core-${CORE_VERSION}.tar.gz -C /opt/ \
    && rm /opt/core-${CORE_VERSION}.tar.gz && mkdir /projects

COPY core-install.sh /root/
COPY api-server /root/api-server
RUN chmod +x /root/core-install.sh && \
    sed -i 's/\r$//' /root/core-install.sh

# Install and start api server
WORKDIR /root
RUN cd api-server && \
    npm i
EXPOSE 3000
CMD [ "node","/root/api-server/index.js" ]
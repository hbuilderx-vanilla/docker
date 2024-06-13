#!/bin/bash
npm config set registry https://registry.npmmirror.com
cd /opt/core/plugins
npm i
cd /opt/core/plugins/uniapp-cli-vite
yarn --force
cd /opt/core/plugins/uniapp-cli
yarn --force
cd /opt/core/plugins/compile-node-sass
npm i -f
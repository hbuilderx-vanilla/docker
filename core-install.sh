#!/bin/bash
npm config set registry https://registry.npmmirror.com
yarn config set registry https://registry.npmmirror.com
export NVM_NODEJS_ORG_MIRROR=https://mirrors.ustc.edu.cn/node/
npm install -g cross-env
cd /opt/core/plugins
npm i
cd /opt/core/plugins/uniapp-cli-vite
yarn --force
cd /opt/core/plugins/uniapp-cli
npm i -f
chmod +x /opt/core/plugins/compile-node-sass/node_modules/node-sass-china/vendor/linux-x64-108/binding.node
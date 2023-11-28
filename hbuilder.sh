#!/bin/bash

# HBuilder目录修改此处
# HBUILDER_DIR=/Users/myd/HbuilderX-vanilla/core
HBUILDER_DIR=/Applications/HBuilderX.app/Contents/HBuilderX
NODE_ENV=production
repoDir=$1
# 导出目录修改此处
distExportDir=$(mktemp -d)
echo $distExportDir
# Nodejs修改此处
# NODE=/Users/myd/HbuilderX-vanilla/core/plugins/node/node
NODE=/Applications/HBuilderX.app/Contents/HBuilderX/plugins/node/node

UNI_INPUT_DIR="$repoDir"
VITE_ROOT_DIR="$UNI_INPUT_DIR"
UNI_HBUILDERX_PLUGINS="$HBUILDER_DIR/plugins"
UNI_CLI_CONTEXT="$UNI_HBUILDERX_PLUGINS/uniapp-cli-vite"
UNI_NPM_DIR="$UNI_HBUILDERX_PLUGINS/npm"
UNI_NODE_DIR="$UNI_HBUILDERX_PLUGINS/node"
UNI_CLI="$UNI_CLI_CONTEXT/node_modules/@dcloudio/vite-plugin-uni/bin/uni.js"

export HBUILDER_DIR
export UNI_INPUT_DIR
export VITE_ROOT_DIR
export UNI_CLI_CONTEXT
export UNI_HBUILDERX_PLUGINS
export UNI_NPM_DIR
export UNI_NODE_DIR
export NODE_ENV
export NODE
export PATH="$PATH:$UNI_INPUT_DIR/node_modules/.bin"

cd "$UNI_CLI_CONTEXT"
buildCommand="$NODE --max-old-space-size=2048 --no-warnings $UNI_CLI build --platform app --outDir $distExportDir/app-wgt-dist"
eval $buildCommand
exitCode=$?
if [ $exitCode -eq 0 ]; then
  echo "Build successful"
  exit 1
else
  echo "Error during build"
  exit 0
fi

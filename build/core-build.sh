#!/bin/bash
core_version=$1
plugins_root=$2
current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
parent_dir="$(dirname "$current_dir")"
core_dir="$parent_dir/core"
if [ -d "$core_dir" ]; then
    rm -rf "$core_dir"
fi
mkdir "$core_dir"
cp -r $current_dir/node $core_dir/
unzip "$current_dir/npm.zip" -d "$core_dir"
cp -r $plugins_root/node_modules/package.json $core_dir/
cp -r $plugins_root/node_modules/package-lock.json $core_dir/
cp -r $plugins_root/about $core_dir/
cp -r $plugins_root/compile-dart-sass $core_dir/
mkdir $core_dir/uniapp-cli-vite
cp $plugins_root/uniapp-cli-vite/index.js $core_dir/uniapp-cli-vite/
cp $plugins_root/uniapp-cli-vite/vite.config.js $core_dir/uniapp-cli-vite/
cp $plugins_root/uniapp-cli-vite/package.json $core_dir/uniapp-cli-vite/
cp $plugins_root/uniapp-cli-vite/package.nls.json $core_dir/uniapp-cli-vite/
cp $plugins_root/uniapp-cli-vite/package.nls.zh_CN.json $core_dir/uniapp-cli-vite/
cp $plugins_root/uniapp-cli-vite/yarn.lock $core_dir/uniapp-cli-vite/
new_dependency='"@esbuild/linux-x64": "0.17.12"'
jq '.devDependencies |= with_entries(select(.key != "@esbuild/darwin-arm64" and .key != "@esbuild/darwin-x64" and .key != "fsevents"))' $core_dir/uniapp-cli-vite/package.json | jq ".devDependencies += {$new_dependency}" > $core_dir/uniapp-cli-vite/temp.json && mv $core_dir/uniapp-cli-vite/temp.json $core_dir/uniapp-cli-vite/package.json
zip -r "$parent_dir/core-3.9.9.zip" "$core_dir"
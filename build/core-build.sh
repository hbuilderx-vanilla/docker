#!/bin/bash
# macOS HbuilderX only
core_version=$1
plugins_root=$2
current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
parent_dir="$(dirname "$current_dir")"
core_dir="$parent_dir/core"
plugins_dir="$core_dir/plugins"
mkdir -p "$plugins_dir"

cp -r "$current_dir/resources/node" "$plugins_dir/"
unzip "$current_dir/resources/npm.zip" -d "$plugins_dir"
unzip "$current_dir/resources/compile-node-sass.zip" -d "$plugins_dir"
unzip "$current_dir/resources/compile-less.zip" -d "$plugins_dir"
cp -r "$current_dir/resources/package.json" "$plugins_dir/"
cp -r "$current_dir/resources/package-lock.json" "$plugins_dir/"
# cp -r "$plugins_root/node_modules/package.json" "$plugins_dir/"
# cp -r "$plugins_root/node_modules/package-lock.json" "$plugins_dir/"
cp -r "$plugins_root/about" "$plugins_dir/"
cp -r "$plugins_root/compile-dart-sass" "$plugins_dir/"
cp -r "$plugins_root/uni_modules" "$plugins_dir/"
cp -r "$plugins_root/uni_helpers" "$plugins_dir/"

# uniapp-cli-vite
mkdir "$plugins_dir/uniapp-cli-vite"
cp "$plugins_root/uniapp-cli-vite/index.js" "$plugins_dir/uniapp-cli-vite/"
cp "$plugins_root/uniapp-cli-vite/vite.config.js" "$plugins_dir/uniapp-cli-vite/"
cp "$plugins_root/uniapp-cli-vite/package.json" "$plugins_dir/uniapp-cli-vite/"
cp "$plugins_root/uniapp-cli-vite/package.nls.json" "$plugins_dir/uniapp-cli-vite/"
cp "$plugins_root/uniapp-cli-vite/package.nls.zh_CN.json" "$plugins_dir/uniapp-cli-vite/"
cp "$plugins_root/uniapp-cli-vite/yarn.lock" "$plugins_dir/uniapp-cli-vite/"

new_dependency='"@esbuild/linux-x64": "0.17.12"'
jq '.devDependencies |= with_entries(select(.key != "@esbuild/darwin-arm64" and .key != "@esbuild/darwin-x64" and .key != "@rollup/rollup-win32-ia32-msvc" and .key != "@rollup/rollup-win32-x64-msvc" and .key != "fsevents"))' "$plugins_dir/uniapp-cli-vite/package.json" | jq ".devDependencies += {$new_dependency}" > "$plugins_dir/uniapp-cli-vite/temp.json" && mv "$plugins_dir/uniapp-cli-vite/temp.json" "$plugins_dir/uniapp-cli-vite/package.json"

# uniapp-cli
new_sass_dependency='"node-sass": "../compile-node-sass/node_modules/node-sass"'
mkdir "$plugins_dir/uniapp-cli"
cp -r "$plugins_root/uniapp-cli/bin" "$plugins_dir/uniapp-cli/"
cp -r "$plugins_root/uniapp-cli/public" "$plugins_dir/uniapp-cli/"
cp -r "$plugins_root/uniapp-cli/types" "$plugins_dir/uniapp-cli/"
cp "$plugins_root/uniapp-cli/babel.config.js" "$plugins_dir/uniapp-cli/"
cp "$plugins_root/uniapp-cli/package.json" "$plugins_dir/uniapp-cli/"
cp "$plugins_root/uniapp-cli/package.nls.json" "$plugins_dir/uniapp-cli/"
cp "$plugins_root/uniapp-cli/package.nls.zh_CN.json" "$plugins_dir/uniapp-cli/"
cp "$plugins_root/uniapp-cli/postcss.config.js" "$plugins_dir/uniapp-cli/"
cp "$plugins_root/uniapp-cli/tsconfig.json" "$plugins_dir/uniapp-cli/"
cp "$plugins_root/uniapp-cli/update.txt" "$plugins_dir/uniapp-cli/"
cp "$plugins_root/uniapp-cli/yarn.lock" "$plugins_dir/uniapp-cli/"

cd "$parent_dir"
tar -czvf "core-$core_version.tar.gz" --exclude='__MACOSX' --exclude='.DS_Store' -C "$parent_dir" "core"


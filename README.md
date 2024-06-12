# HBuilderX Vanilla

*Entities should not be multiplied unnecessarily.  —— William of Occam*

HBuilderX Vanilla 提供了一个小巧的容器环境以及一套对外暴露的api，用来构建Uniapp-Vite-Vue 3项目的wgt热更新包。

## Quick Start

容器启动示例：

```sh
docker run -d --restart=always -v <projects_folder>:/projects -p 13300:3000 --name hbuilder-vanilla flymyd114/hbuilderx-vanilla:latest
```

* `<projects_folder>`是本机的待打包工程父目录，你的所有工程均应处于该目录下，如`/Users/myd/projects`下有`hello-uniapp`文件夹。
* `13300`为建议的API端口映射点。

容器首次启动后，执行如下命令以初始化依赖：

```sh
docker exec -it hbuilder-vanilla sh -c "chmod +x /root/core-install.sh && /root/core-install.sh"
```

访问`http://127.0.0.1:13300`以检查API服务是否正确启动。

打包示例：

```sh
curl --location 'http://127.0.0.1:13300/build?project=crp-app'
```

产物将会在`/projects/crp-app/wgt-dist`中生成。

## 自行构建指定版本

1、克隆本仓库  

```shell
git clone --filter=blob:limit=4m https://github.com/hbuilderx-vanilla/docker.git
```

2、执行打包脚本以从本机的HBuilderX中提取核心：

**以HbuilderX 3.9.9为例：第一个参数为HbuilderX版本号，第二个参数为HbuilderX的plugins文件夹路径。**

```shell
# macOS
cd build
./core-build.sh 3.9.9 /Applications/HBuilderX.app/Contents/HBuilderX/plugins

# Windows (实验性)
cd build
./core-build.ps1 3.9.9 "D:\HBuilderX\plugins"
```

3、修改Dockerfile-China-Mainland、执行Docker构建脚本并运行测试：

```shell
# 修改Dockerfile-China-Mainland第17行，将ARG CORE_VERSION=3.9.9替换为你构建的核心版本
cd test
./build.sh
# 指定要挂载的工程父目录，如/root/projects
./run.sh /root/projects
# 初始化依赖
docker exec -it hbuilder-vanilla sh -c "chmod +x /root/core-install.sh && /root/core-install.sh"
# 测试是否正常启动
curl --location 'http://127.0.0.1:13300'
# 测试打包
curl --location 'http://127.0.0.1:13300/build?project=crp-app'
# 一键删除容器及镜像
./del.sh
```


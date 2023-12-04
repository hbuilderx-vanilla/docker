# HBuilderX Vanilla

*Entities should not be multiplied unnecessarily.  —— William of Occam*

HBuilderX Vanilla 提供了一个小巧的容器环境以及一套对外暴露的api，用来构建Uniapp-Vite-Vue 3项目的wgt热更新包。

容器启动示例：

```sh
docker run -d --restart=always -v /<user_name>/<projects_folder>:/projects -p 13300:3000 --name hbuilder-vanilla flymyd114/hbuilderx-vanilla:latest
```

* `/<user_name>/<projects_folder>`是本机的待打包工程父目录，你的所有工程均应处于该目录下，如`/Users/myd/projects`下有`hello-uniapp`文件夹。
* `13300`为建议的API端口映射点。

容器首次启动后，执行如下命令以初始化依赖：

```sh
docker exec -it <docker_id> /bin/sh
chmod +x /root/core-install.sh && /root/core-install.sh
exit
```

访问`http://127.0.0.1:13300`以检查API服务是否正确启动。

打包示例：

```sh
curl --location 'http://localhost:13300/build?project=crp-app'
```

产物将会在`/projects/crp-app/wgt-dist`中生成。

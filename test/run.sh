# docker run --name hbuilder-vanilla -it hbuilder-vanilla
docker run -d --restart=always -v /Users/myd/projects:/projects -p 13300:3000 --name hbuilder-vanilla hbuilder-vanilla
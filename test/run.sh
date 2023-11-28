# docker run --name hbuilder-core -it hbuilder-core
docker run -d --restart=always -v /Users/myd/projects:/projects -p 13300:3000 --name hbuilder-core hbuilder-core
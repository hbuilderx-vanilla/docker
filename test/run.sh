#!/bin/bash
project_dir=${1:-"/Users/myd/projects"}
docker run -d --restart=always -v "$project_dir":/projects -p 13300:3000 --name hbuilder-vanilla hbuilder-vanilla
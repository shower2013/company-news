#!/usr/bin/env bash

clone_optional() {
  # simple check if the project is cloned
  if [ "$(basename $PWD)" != companyNews ]; then
    echo 'not have project yet, cloning...'
    git clone -b master --single-branch \
      https://github.com/shower2013/company-news.git companyNews &&
      cd "$_"

    echo 'project cloned'
  fi
}

build() {
  ./gradlew clean warNoStatic warCopy zipStatic artifactsCopy
}

commit_push() {
  if [ -z "$1" ]; then
    echo "update artifacts only"
    git pull && git add . && git commit -am "update artifacts" && git push
  else
    echo "commit and push changes"
    git pull && git add . && git commit -am "$1" && git push
  fi
}

deploy() {
  cd docker &&
    docker-compose down &&
    docker rmi -f docker_proxy docker_app

  docker-compose up
}

# script start

# TODO check if requested tools are installed
# git, docker, docker-compose

clone_optional
build
commit_push "$1"
deploy

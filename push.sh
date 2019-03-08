#!/bin/bash
if [ $# -ne 2 ]; then
  echo "Usage push-production.sh <version> <profile>" 1>&2
  exit 1
fi
VERSION=$1
PROFILE=$2

if [ -z "$(git branch | grep '*' | grep productio)" ];then
   echo "Branch is not production" 1>&2
   exit 1;
fi

git fetch

if [ -n "$(git diff)" ];then
   echo "Please 'git diff'" 1>&2
   exit 1;
fi

if [ -n "$(git diff HEAD..origin/production)" ];then
   echo "Please 'git diff HEAD..origin/production.'" 1>&2
   exit 1;
fi

if [ -n "$(git ls-remote --tags | grep -e "$VERSION")" ];then
   echo "already used $VERSION" 1>&2
   exit 1;
fi

$(aws ecr get-login --no-include-email --region ap-northeast-1 --profile $PROFILE)
if [ $? -gt 0 ]; then
    exit 1;
fi

git tag $VERSION
git push origin tag $VERSION
echo "pushed git tag $VERSION"

docker build -t yyy .
echo "docker build done"

echo "docker tag yyy:latest xxx.ecr.ap-northeast-1.amazonaws.com/yyy:latest"
echo "docker push xxx.ecr.ap-northeast-1.amazonaws.com/yyy:latest"

echo "docker tag yyy:latest xxx.ecr.ap-northeast-1.amazonaws.com/yyy:$VERSION"
echo "docker push xxx.ecr.ap-northeast-1.amazonaws.com/yyy:$VERSION"
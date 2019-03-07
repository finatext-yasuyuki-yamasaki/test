#!/bin/bash

if [ -z "$(git branch | grep '*' | grep productio)" ];then
   echo "Branch is not production"
   exit 1;
fi

git fetch

if [ -n "$(git diff HEAD..origin/production)" ];then
   echo "Please 'git diff HEAD..origin/production.'"
   exit 1;
fi
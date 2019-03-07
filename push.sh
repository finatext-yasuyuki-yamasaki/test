#!/bin/bash

if [ -z "$(git branch | grep '*' | grep productio)" ];then
   echo "Branch is not production"
   exit 1;
fi

if [ -n "$(git diff)" ];then
   echo "Branch is not production!"
   exit 1;
fi
"Branch is not production!!"
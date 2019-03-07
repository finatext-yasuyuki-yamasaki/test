#!/bin/bash

if [ -z "$(git branch | grep '*' | grep productio)" ];then
   echo "Branch is not production"
   exit 1;
fi
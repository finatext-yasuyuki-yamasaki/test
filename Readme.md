#!/bin/bash

if [ -z $(git branch | grep "*" | grep productio) ]; then
   echo "productionじゃない"
fi
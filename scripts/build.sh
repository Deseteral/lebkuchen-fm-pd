#!/bin/sh
PROJECT_NAME="$(basename $PWD)"

rm -rf ./build
mkdir -p ./build

pdc -sdkpath $HOME/Developer/PlaydateSDK "./source" "./build/$PROJECT_NAME"

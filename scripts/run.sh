#!/bin/sh
PROJECT_NAME="$(basename $PWD)"

pkill -9 "Playdate Simulator" || true
open "$HOME/Developer/PlaydateSDK/bin/Playdate Simulator.app" "./build/$PROJECT_NAME.pdx"


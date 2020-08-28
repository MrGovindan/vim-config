#!/bin/sh
current_folder=${PWD##*/}
go_back=0

if [ "$current_folder" != "build" ]; then
  cd build
  go_back=1
fi

compdb -p . list > compile_commands2.json
rm compile_commands.json
mv compile_commands2.json compile_commands.json

if [ "$go_back" -eq 1 ]; then
  cd ../
fi

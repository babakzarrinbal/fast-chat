#!/bin/sh


version="managbl-v1.0.0"
package="ghcr.io/managbl-ai/fast-chat/dev"
local_name="fast-chat"
default_commands="" # build | run | dev | push

# windows compatibility
export MSYS_NO_PATHCONV=1;


# Set a trap to always change back to the original path
original_path=$(pwd)
trap 'cd "$original_path"' EXIT


cd "$(dirname "$0")" && cd ..

if [ "$#" -eq 0 ]; then
  # Use the variable to set the default arguments
  set -- $default_args
fi


# build step
if echo " $@ " | grep -q " build "; then
  docker-compose down -v --rmi all
  docker-compose build
fi

if echo " $@ " | grep -q " push "; then
  docker push $package:$version
  docker push $package:latest
fi

if echo " $@ " | grep -q " run"; then
  docker-compose up --build -d
fi

if echo " $@ " | grep -q " dev "; then
  docker stop "$local_name"
  docker rm "$local_name"
  docker-compose up --build -d
  docker exec -it "$local_name" bash
fi

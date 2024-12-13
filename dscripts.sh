#!/bin/sh
version="managbl-v1.0.0"
package="ghcr.io/managbl-ai/fast-chat/dev"
local_name="fast-chat"

if [ "$#" -eq 0 ]; then
  set -- build run
fi

if echo " $@ " | grep -q " build "; then
  docker-compose down -v --rmi all
  docker-compose build
  # if [ -f .env ]; then
  #   build_args=$(grep -v '^#' .env | awk '{print "--build-arg " $0}' | tr '\n' ' ')
  # fi

  # docker build \
  #   -t $package:latest \
  #   -t $package:$version \
  #   $build_args \
  #   -f Dockerfile .
fi

# if echo " $@ " | grep -q " push "; then
#   docker push $package:$version
#   docker push $package:latest
# fi

if echo " $@ " | grep -q " run"; then
  docker-compose up --build -d
  # docker run \
  #   --network host \
  #   --gpus all \
  #   --name "$local_name" \
  #   -it $package:latest
fi

# if echo " $@ " | grep -q " dev "; then
#   docker stop "$local_name"
#   docker rm "$local_name"
#   docker run \
#     --network host \
#     --gpus all -d \
#     -v "$(pwd):/app" \
#     -p 8080:8080 \
#     --name "$local_name" \
#     -it $package:latest tail -f /dev/null
#   echo "entrypoint: ./run_mistral.nim"
#   docker exec -it "$local_name" bash
# fi

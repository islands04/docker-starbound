#!/bin/bash

# Build changes (if necessary)
./docker_build.sh

# Run a container
docker run -p 0.0.0.0:21025:21025/tcp --env-file .env -v "/servers/starbound:/steamcmd/starbound" --name starbound-server -it --rm islands04/starbound-server:latest


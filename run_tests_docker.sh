#!/usr/bin/env bash

# This script will run robot tests in docker container.

DOCKER_IMAGE_NAME="robot-image"

docker run --rm \
           -e USERNAME="Robot Testes" \
           --net=host \
           -v "$PWD/output":/output \
           -v "$PWD/suites":/suites \
           -v "$PWD/scripts":/scripts \
           -v "$PWD/reports":/reports \
           -v "$PWD/pythonpath":/usr/local/bin/pythonpath \
           --security-opt seccomp:unconfined \
           --shm-size "256M" \
 	   ${DOCKER_IMAGE_NAME}
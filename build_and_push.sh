#!/usr/bin/env bash

IMAGE_NAME=$1
BASE_IMAGE=$2

# Authenticate with GitHub Container Registry
echo $GHCR_PAT | docker login ghcr.io -u $GITHUB_ACTOR --password-stdin

# Build the Docker image with the appropriate tags
docker build --network=host --pull \
--build-arg BASE_IMAGE=$BASE_IMAGE \
-t ghcr.io/${GITHUB_REPOSITORY_OWNER}/${IMAGE_NAME}:latest \
-t ghcr.io/${GITHUB_REPOSITORY_OWNER}/${IMAGE_NAME}:latest-stable \
-f ./${IMAGE_NAME}/Dockerfile ${IMAGE_NAME}

# Push stable and latest tags for the main branch
if [ "$GITHUB_REF_NAME" == "main" ] || [ "$GITHUB_REF_NAME" == "master" ]; then
    docker push ghcr.io/${GITHUB_REPOSITORY_OWNER}/${IMAGE_NAME}:latest-stable
fi

# Push the latest tag
docker push ghcr.io/${GITHUB_REPOSITORY_OWNER}/${IMAGE_NAME}:latest

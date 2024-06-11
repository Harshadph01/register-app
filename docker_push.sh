#!/bin/bash

# Get login credentials from environment variables (assuming they are set)
dockerUsername=${DOCKER_USER}
dockerPassword=${DOCKER_PASS}

# Login to Docker Hub
echo "Logging in to Docker Hub..."
docker login -u "$dockerUsername" -p "$dockerPassword"

# Build the Docker image
echo "Building image: ${IMAGE_NAME}:${IMAGE_TAG}"
docker build -t "${IMAGE_NAME}:${IMAGE_TAG}" .

# Push the tagged image
echo "Pushing image: ${IMAGE_NAME}:${IMAGE_TAG}"
docker push "${IMAGE_NAME}:${IMAGE_TAG}"

# Optionally push the 'latest' tag
if [[ ! -z "$PUSH_LATEST" ]]; then
  echo "Pushing image: ${IMAGE_NAME}:latest"
  docker push "${IMAGE_NAME}:latest"
fi

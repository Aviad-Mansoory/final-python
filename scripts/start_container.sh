#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME="aviadma/devops-final-python:latest"
CONTAINER_NAME="devops-final-python"

echo "Pulling Docker image '${IMAGE_NAME}'..."

if ! docker pull "${IMAGE_NAME}"; then
    echo "ERROR: Failed to pull Docker image '${IMAGE_NAME}'." >&2
    exit 1
fi

echo "Checking for stale container '${CONTAINER_NAME}'..."

if docker container inspect "${CONTAINER_NAME}" >/dev/null 2>&1; then
    echo "Removing stale container '${CONTAINER_NAME}'..."
    docker stop "${CONTAINER_NAME}" || true
    docker rm "${CONTAINER_NAME}" || true
fi

echo "Starting container '${CONTAINER_NAME}'..."

if ! docker run -d \
    --name "${CONTAINER_NAME}" \
    --restart unless-stopped \
    -p 80:5000 \
    "${IMAGE_NAME}"; then

    echo "ERROR: Failed to start Docker container '${CONTAINER_NAME}'." >&2
    exit 1
fi

echo "Container '${CONTAINER_NAME}' started successfully."
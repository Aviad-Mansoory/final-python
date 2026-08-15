#!/usr/bin/env bash
set -euo pipefail

CONTAINER_NAME="devops-final-python"

echo "Checking if container '${CONTAINER_NAME}' exists..."

if docker container inspect "${CONTAINER_NAME}" >/dev/null 2>&1; then
    echo "Stopping container '${CONTAINER_NAME}'..."
    docker stop "${CONTAINER_NAME}" || true

    echo "Removing container '${CONTAINER_NAME}'..."
    docker rm "${CONTAINER_NAME}" || true

    echo "Container '${CONTAINER_NAME}' stopped and removed."
else
    echo "No container named '${CONTAINER_NAME}' found. Skipping stop."
fi
#!/usr/bin/env bash
set -euo pipefail

echo "Verifying deployment prerequisites on EC2 host..."

if ! command -v docker >/dev/null 2>&1; then
    echo "ERROR: Docker is not installed or not available in PATH." >&2
    exit 1
fi

if ! command -v curl >/dev/null 2>&1; then
    echo "ERROR: curl is not installed or not available in PATH." >&2
    exit 1
fi

echo "Prerequisites check passed: Docker and curl are available."
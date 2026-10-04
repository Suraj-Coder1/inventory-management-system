#!/usr/bin/env bash

set -euo pipefail

CONFIG_FILE="${1:-deploy-config/inventory.env.example}"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "ERROR: Configuration file not found: $CONFIG_FILE"
    exit 1
fi

set -a
source "$CONFIG_FILE"
set +a

required_vars=(
    APP_NAME
    APP_SLUG
    K8S_NAMESPACE
    APP_PORT
    HEALTH_PATH
    K8S_MANIFESTS
    DOCKERFILES
    DOCKER_IMAGES
)

for var in "${required_vars[@]}"; do
    if [ -z "${!var:-}" ]; then
        echo "ERROR: Required configuration is missing: $var"
        exit 1
    fi
done

echo "Configuration loaded successfully."
echo "Application: $APP_NAME"
echo "Slug: $APP_SLUG"
echo "Namespace: $K8S_NAMESPACE"
echo "Application port: $APP_PORT"
echo "Health path: $HEALTH_PATH"
echo "Kubernetes manifests: $K8S_MANIFESTS"
echo "Dockerfiles: $DOCKERFILES"
echo "Docker images: $DOCKER_IMAGES"

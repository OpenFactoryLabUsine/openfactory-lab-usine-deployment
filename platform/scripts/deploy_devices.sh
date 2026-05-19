#!/bin/bash
# ==============================================================================
# Deploy devices of Lab-Usine
# ------------------------------------------------------------------------------
# This deployment script handles the provisioning of physical and virtual devices
# for the Lab-Usine within OpenFactory.
#
# Notes:
# - This script assumes factory-manager-lab-usine container is available
# ==============================================================================

OFA_CONTAINER_NAME="factory-manager-lab-usine"

echo "🔍 Checking if container '$OFA_CONTAINER_NAME' exists and is running..."

if ! docker ps --format '{{.Names}}' | grep -q "^${OFA_CONTAINER_NAME}$"; then
  echo "❌ Error: Required container '$OFA_CONTAINER_NAME' is not running or does not exist."
  echo "👉 Please start it first (e.g. 'docker start $OFA_CONTAINER_NAME') and re-run this script."
  exit 1
fi

echo "✅ Container '$OFA_CONTAINER_NAME' is running. Starting deployment..."
echo

set -e  # Exit immediately if any command fails

# Deploy devices from PLT-3013 on OpenFactory
echo "🚀 Deploying Assembly area assets to OpenFactory"
docker exec "$OFA_CONTAINER_NAME" ofa device up lab-usine/plt-3013/dust-trak.yml

echo
echo "✅ Deployment completed successfully!"

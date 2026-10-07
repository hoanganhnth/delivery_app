#!/bin/sh
set -eu
app_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
# Override for worktrees, which are not siblings of backend_delivery.
backend_api=${1:-"$app_root/../backend_delivery/docs/platform/system/api"}
mkdir -p "$app_root/contracts/backend"
for manifest in http-contract.json public-edge-manifest.json; do
  cp "$backend_api/$manifest" "$app_root/contracts/backend/$manifest"
done

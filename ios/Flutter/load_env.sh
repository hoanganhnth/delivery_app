#!/bin/bash
# Script to load environment variables from .env into xcconfig files
# This runs before iOS build to inject Mapbox token

ENV_FILE="../../.env"

if [ -f "$ENV_FILE" ]; then
    # Read MAPBOX_ACCESS_TOKEN from .env
    MAPBOX_TOKEN=$(grep MAPBOX_ACCESS_TOKEN "$ENV_FILE" | cut -d '=' -f2)
    
    if [ -n "$MAPBOX_TOKEN" ]; then
        echo "MAPBOX_ACCESS_TOKEN=$MAPBOX_TOKEN"
    else
        echo "MAPBOX_ACCESS_TOKEN=your_mapbox_access_token_here"
    fi
else
    echo "MAPBOX_ACCESS_TOKEN=your_mapbox_access_token_here"
fi

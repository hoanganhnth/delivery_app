# Setup Script for Mapbox Token

This script helps you set up the Mapbox access token for local development.

## Quick Setup

1. **Get your Mapbox token** from https://account.mapbox.com/access-tokens/

2. **Set environment variables:**

### For Android (gradle.properties)
```bash
# Replace YOUR_TOKEN with your actual Mapbox token
echo "MAPBOX_ACCESS_TOKEN=YOUR_TOKEN" >> android/gradle.properties
```

### For iOS (Debug.xcconfig & Release.xcconfig)
```bash
# Replace YOUR_TOKEN with your actual Mapbox token
TOKEN="YOUR_TOKEN"
sed -i '' "s/your_mapbox_access_token_here/$TOKEN/" ios/Flutter/Debug.xcconfig
sed -i '' "s/your_mapbox_access_token_here/$TOKEN/" ios/Flutter/Release.xcconfig
sed -i '' "s/your_mapbox_access_token_here/$TOKEN/" ios/Flutter/environment.plist
```

### For Flutter (.env file)
```bash
# Replace YOUR_TOKEN with your actual Mapbox token
echo "MAPBOX_ACCESS_TOKEN=YOUR_TOKEN" > .env
```

## Security Notes

⚠️ **IMPORTANT**: These files contain your real token and should NEVER be committed to git:
- `android/gradle.properties` (contains real token)
- `ios/Flutter/Debug.xcconfig` (contains real token)  
- `ios/Flutter/Release.xcconfig` (contains real token)
- `ios/Flutter/environment.plist` (contains real token)
- `.env` (contains real token)

The git repository only contains placeholder values (`your_mapbox_access_token_here`).

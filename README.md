# Delivery App

A Flutter delivery application with real-time features.

## Environment Setup

### Mapbox Configuration
1. Copy `.env.example` to `.env`
2. Get your Mapbox access token from [Mapbox Account](https://account.mapbox.com/access-tokens/)
3. Add your token to `.env`:
   ```
   MAPBOX_ACCESS_TOKEN=your_token_here
   ```

### Development
1. Install dependencies: `fvm flutter pub get`
2. Run code generation: `fvm dart run build_runner build --delete-conflicting-outputs`
3. Run app: `fvm flutter run --dart-define-from-file=.env`

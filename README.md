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
3. Run app with the local Gateway fallback: `fvm flutter run`
4. For a device or staging Gateway, pass its origin explicitly:
   `fvm flutter run --dart-define=API_BASE_URL=https://gateway.example.com`

The `.env` file is used for the Mapbox asset. Firebase files and production
credentials are injected by the deployment environment and must not be
committed. Android also needs `MAPBOX_ACCESS_TOKEN` as a Gradle property or
environment variable for the native manifest placeholder; see
`MAPBOX_SETUP.md`.

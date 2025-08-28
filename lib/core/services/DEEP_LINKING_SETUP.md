# Deep Linking Setup Guide

Deep linking allows users to open specific screens in your app directly from URLs, whether from web browsers, other apps, or shared links.

## ✅ What's Implemented

### 1. **Deep Link Service (using app_links package)**
- Handles incoming deep links via app_links package
- Processes different URL patterns
- Generates shareable links
- Supports custom URL schemes and universal links
- Real-time link listening and initial link detection

### 2. **App Links Package Integration**
- Uses `app_links: ^6.4.1` package for cross-platform deep linking
- Automatic platform-specific handling
- Stream-based link listening
- Initial link detection for cold app starts

### 3. **Platform Configuration**
- **Android**: Intent filters in AndroidManifest.xml
- **iOS**: URL schemes and associated domains in Info.plist
- **Web**: Automatic handling via go_router

### 4. **Share Service**
- Generate and share restaurant links
- Generate and share order links
- Generate and share promo codes
- Copy links to clipboard

## 🔗 Supported Deep Link Patterns

### Custom URL Scheme
```
deliveryapp://restaurant?id=rest_1
deliveryapp://order?id=ORD1001
deliveryapp://track?order_id=ORD1001
deliveryapp://promo?code=SAVE20
```

### Universal Links (HTTPS)
```
https://deliveryapp.com/restaurant?id=rest_1
https://deliveryapp.com/order?id=ORD1001
https://deliveryapp.com/track?order_id=ORD1001
https://deliveryapp.com/promo?code=SAVE20
https://deliveryapp.com/reset-password?token=abc123
https://deliveryapp.com/verify-email?token=xyz789
```

### Development Links
```
https://deliveryapp.dev/restaurant?id=rest_1
https://deliveryapp.dev/order?id=ORD1001
```

## 📱 Platform Setup

### Android Configuration
File: `android/app/src/main/AndroidManifest.xml`

```xml
<!-- Custom URL scheme: deliveryapp:// -->
<intent-filter android:autoVerify="true">
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="deliveryapp" />
</intent-filter>

<!-- HTTPS deep links -->
<intent-filter android:autoVerify="true">
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="https"
          android:host="deliveryapp.com" />
</intent-filter>
```

### iOS Configuration
File: `ios/Runner/Info.plist`

```xml
<!-- URL Schemes -->
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLName</key>
        <string>deliveryapp.deeplink</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>deliveryapp</string>
        </array>
    </dict>
</array>

<!-- Associated Domains for Universal Links -->
<key>com.apple.developer.associated-domains</key>
<array>
    <string>applinks:deliveryapp.com</string>
    <string>applinks:deliveryapp.dev</string>
</array>
```

## 🛠 App Links Package Setup

### 1. **Dependencies**
```yaml
dependencies:
  app_links: ^6.4.1
```

### 2. **Service Implementation**
```dart
class DeepLinkService {
  static AppLinks? _appLinks;
  static GoRouter? _router;

  static Future<void> initialize(GoRouter router) async {
    _router = router;
    _appLinks = AppLinks();

    // Listen for incoming deep links
    _appLinks!.uriLinkStream.listen((Uri uri) {
      _processDeepLink(uri);
    });

    // Get initial deep link
    final Uri? initialUri = await _appLinks!.getInitialLink();
    if (initialUri != null) {
      _processDeepLink(initialUri);
    }
  }
}
```

## 🛠 Usage Examples

### 1. Generate Deep Links
```dart
final shareService = ref.watch(shareServiceProvider);

// Generate restaurant link
final restaurantLink = DeepLinkService.generateRestaurantLink(
  'https://deliveryapp.com',
  'rest_1',
);

// Generate order link
final orderLink = DeepLinkService.generateOrderLink(
  'https://deliveryapp.com',
  'ORD1001',
);

// Generate promo link
final promoLink = DeepLinkService.generatePromoLink(
  'https://deliveryapp.com',
  'SAVE20',
);
```

### 2. Share Content
```dart
// Share restaurant
await shareService.shareRestaurant('rest_1', 'Amazing Restaurant');

// Share order
await shareService.shareOrder('ORD1001');

// Share promo
await shareService.sharePromo('SAVE20', '20% off your order');
```

### 3. Handle Deep Links in UI
```dart
// Restaurant details screen with share button
IconButton(
  icon: const Icon(Icons.share),
  onPressed: () async {
    await shareService.shareRestaurant(restaurantId, restaurantName);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Link copied to clipboard!')),
    );
  },
),
```

## 🧪 Testing Deep Links

### 1. **Custom URL Scheme Testing**
```bash
# Android (using ADB)
adb shell am start \
  -W -a android.intent.action.VIEW \
  -d "deliveryapp://restaurant?id=rest_1" \
  com.example.delivery_app

# iOS (using Simulator)
xcrun simctl openurl booted "deliveryapp://restaurant?id=rest_1"
```

### 2. **Universal Links Testing**
```bash
# Test in browser or share via message
https://deliveryapp.com/restaurant?id=rest_1
https://deliveryapp.com/order?id=ORD1001
https://deliveryapp.com/track?order_id=ORD1001
```

### 3. **Demo Widget Testing**
- Use the `DeepLinkDemoWidget` on home screen
- Copy generated links
- Test in browser or share via message
- Verify app opens to correct screen

## 🔄 Deep Link Flow

1. **User clicks link** (from browser, message, etc.)
2. **OS opens app** (if installed) or app store (if not)
3. **DeepLinkService processes URL**
4. **Router navigates** to appropriate screen
5. **Guards check permissions** (auth, admin, etc.)
6. **Screen displays** with correct data

## 📋 Link Patterns Reference

| Pattern | Example | Destination |
|---------|---------|-------------|
| `/restaurant?id=X` | `deliveryapp://restaurant?id=rest_1` | Restaurant details |
| `/menu?restaurant_id=X` | `deliveryapp://menu?restaurant_id=rest_1` | Restaurant menu |
| `/order?id=X` | `deliveryapp://order?id=ORD1001` | Order details |
| `/track?order_id=X` | `deliveryapp://track?order_id=ORD1001` | Order tracking |
| `/promo?code=X` | `deliveryapp://promo?code=SAVE20` | Restaurants with promo |
| `/reset-password?token=X` | `deliveryapp://reset-password?token=abc` | Password reset |
| `/verify-email?token=X` | `deliveryapp://verify-email?token=xyz` | Email verification |
| `/share?type=X&id=Y` | `deliveryapp://share?type=restaurant&id=rest_1` | Shared content |

## 🚀 Production Setup

### 1. **Domain Verification**
- Add `apple-app-site-association` file to your domain
- Add `assetlinks.json` file for Android
- Configure DNS and SSL certificates

### 2. **App Store Configuration**
- Configure associated domains in Apple Developer Console
- Configure app links in Google Play Console
- Test with App Store Connect

### 3. **Analytics**
- Track deep link opens
- Monitor conversion rates
- A/B test different link formats

## 🔧 Advanced Features

### 1. **Deferred Deep Links**
- Handle links when app is not installed
- Store link data and process after installation

### 2. **Dynamic Links**
- Generate links that work across platforms
- Include fallback URLs for web

### 3. **Link Attribution**
- Track link sources and campaigns
- Measure marketing effectiveness

## 🐛 Troubleshooting

### Common Issues:
1. **Links not opening app**: Check intent filters and URL schemes
2. **Wrong screen opens**: Verify URL parsing logic
3. **Auth redirects**: Ensure guards handle deep link state
4. **iOS universal links**: Verify associated domains setup

### Debug Steps:
1. Check platform configuration files
2. Test with simple custom scheme first
3. Verify URL parsing in DeepLinkService
4. Check router guard logic
5. Test on physical devices

Deep linking provides a seamless way for users to access specific content in your app! 🔗

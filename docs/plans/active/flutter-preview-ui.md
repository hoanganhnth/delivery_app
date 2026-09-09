# Flutter preview UI migration

Authority: user-approved phased plan in this task, September 8, 2026.
Design reference: delivery_web customer-preview phone mode. Flutter native UI;
User follow-up supersedes the first batch's exclusions: reproduce all Home
discovery blocks, use display mocks where data is missing, and hide failed Flash
Sale. No backend contract changes or mock checkout writes.

## Batch 1: Home and navigation
- [x] Baseline focused tests and preserve existing dirty changes.
- [x] Split home header/search, shortcuts, restaurant list and livestream UI.
- [x] Apply preview spacing, typography and flat section styling locally.
- [x] Preserve intents, catalog/address data, tab state and cart badge.
- [x] Test light/dark, long content, loading/empty/error and navigation.
- [x] Inspect rendered evidence; report deviations and await review.

## Batches 2-6
- [x] Search, restaurants and item sheet use preview-aligned components.
- [x] Cart, checkout, addresses and voucher selection use preview-aligned
  surfaces and navigation.
- [x] Orders list and order detail use preview-aligned tabs, cards, status hero,
  summary and address sections; real tracking remains the data source.
- [x] Account, personal information and settings use preview-aligned sections;
  authentication forms now use the shared ShopeeFood auth shell.
- [x] Audit remaining existing screens without a direct preview counterpart
  (tracking adapters, voucher wallet, support, livestream, payments, debug,
  entitlements, splash and refund history) and standardize their shared chrome.

## Constraints and recovery
Work directly in the current checkout with user permission. Existing uncommitted
changes belong to the user; no reset, blanket deletion or automatic commit.
Only remove old presentation implementations after consumers migrate. Keep
business ports and routes. Mock offers/dishes are display-only and open a labelled
sheet. Missing restaurant data uses isolated fixtures; negative fixture IDs are
intercepted in Home and never routed into business APIs. Preserve existing real
restaurant navigation, prices and checkout. No fake order success.
Recovery is a scoped reversal of this batch's patch, never checkout-wide reset.

## Evidence
### Restaurant metadata follow-up (September 9)
- User requested temporary missing-field mocks on Home restaurant items.
- Home card supplies rating 4.8, distance 1.2 km and ETA 20–30 minutes only when
  the respective API field is null. Zero values remain real values.
- Added optional preferred badge to the shared renderer; only the Home/catalog
  adapter opts into it. No persistence, API identity, sorting or checkout changes.
- New regression failed before implementation; 13 focused metadata/layout/item
  tests passed after implementation. Simulator was not restarted for this edit.

### Home fidelity correction (September 9)
- Added swipeable three-page promotional carousel, indicators, five preview
  categories, sample voucher strip, horizontal suggested dishes and sorted/filterable
  restaurant section. Gray canvas and padded white sections follow preview CSS.
- Menu suggestions use the existing lookup port for at most four featured quans;
  absent optional data falls back to preview fixtures. Real dish taps route with
  real restaurant IDs; mock taps open a labelled non-orderable sheet.
- Flash Sale error view returns zero-size content. Live/empty/loading behavior
  otherwise remains unchanged. Livestream is retained below discovery content.
- Focused UI tests: 20 passed; suggestion provider tests: 2 passed. Accessibility
  regression: 4 passed after resolving 360px banner overflow and scrolling to the
  newly lower restaurant section. New checks include carousel swipe, category
  filtering and preventing mock identities reaching real navigation.
- Simulator inspection confirmed populated carousel photos, API menu photos/prices,
  white discovery sections, category row and no Flash Sale error gap. User took
  over Simulator; further UI control stopped.
- Final full suite: 423 tests passed (normal golden verification included), log
  `/tmp/home-discovery-final-suite.log`. Analyzer: no issues. Final iOS simulator
  build passed. The inspected running build preceded the final banner typography
  adjustment; the latest built artifact was not reinstalled after user takeover.
- Header intentionally retains real notification/cart actions rather than fake
  mini-app close/back controls. No claim of pixel-exact parity is made.

### Orders and authentication continuation (September 9)
- Order detail now has a 50px preview header, status hero, order summary,
  delivery address section and preview-styled cancellation action. Existing
  tracking and typed intents remain the source of behavior.
- Authentication login, registration, forgot-password and reset-password views
  now share the ShopeeFood mark, white auth surface, underline fields and orange
  compact CTA. Existing validation, Google login, password recovery and submit
  callbacks are preserved.
- Removed only unused legacy auth presentation widgets after all consumers were
  migrated; no backend contracts or auth state were changed.
- No new tests were created in this continuation. Existing auth tests (6) and
  Orders layout tests (7) passed; analyzer reported no issues after the latest
  auth cleanup. Full-suite verification remains a final gate.

### Remaining-screen audit (September 9)
- Standardized the shared preview canvas, white section surfaces, compact
  headers and bottom navigation across voucher wallet, support, livestream,
  notifications, payments, entitlements, debug tools, splash and refund
  history. Existing business actions and API-backed state remain in place.
- Tracking screens keep their real polling/map adapters and now use the same
  preview-styled chrome around those stateful sections. Refund history keeps
  its existing empty-state copy and navigation intent.
- No new UI tests were added for this audit, per user request. Validation used
  the existing suite only: 425 tests passed, analyzer reported no issues, and
  `git diff --check` passed.

### Divider color correction (September 9)
- Preview bottom navigation now accepts an explicit preview divider color, and
  the address location card uses the same token. Previously Flutter fell back
  to `onSurface` for `outlineVariant`, making address/cart separators appear
  black in the light preview.
- No new tests were added. Existing cart/address presentation tests (10)
  and the existing preview golden suite (3) passed after the scoped fix;
  analyzer and `git diff --check` reported no issues.

### Home typography correction (September 9)
- Compared the live Home preview CSS and Flutter Simulator output. The preview
  uses `Arial, -apple-system` with 17px/600 section headings, while Flutter
  Home was inheriting the native `Plus Jakarta Sans` theme and looked visibly
  wider/rounder.
- Added preview-scoped typography: iOS prefers Arial, while non-iOS/test
  targets retain the bundled Plus Jakarta Sans fallback so Vietnamese glyphs
  remain available. Home content and preview bottom navigation now inherit the
  scoped typography without changing the native app theme globally.
- Rebuilt and installed the iOS Simulator build; visual inspection confirmed
  Vietnamese glyphs render correctly and the Home hierarchy is closer to the
  reference. Existing Home golden/layout/accessibility checks (16) passed;
  no new tests were added.

### Earlier batch evidence (superseded visual exclusions below)
Batch 1 implemented; later batches are recorded above.

- Shell Flutter was 3.29.3/Dart 3.7.2 and could not resolve the repo SDK range.
  Used the repository-pinned `/Users/a/fvm/versions/3.32.8/bin/flutter` instead.
- Baseline Home/navigation: six tests passed. Two new layout/retry tests failed
  against the old implementation, then passed after replacement.
- Focused regression set: 20 tests passed (Home, navigation, catalog boundaries,
  compact row and item sheet). New matrix includes 375x812, 390x844, 430x932,
  light/dark, 200% text with livestream content, and loading/empty/error states.
- Full `flutter test --no-pub --reporter expanded`: 417 tests passed.
  Local run log: `/tmp/delivery-home-batch1-tests.log` (temporary artifact).
- `flutter analyze --no-pub`: no issues. `git diff --check`: passed.
- Home golden inspected before updating only `home_light_vi_360.png`; full suite
  subsequently passed with normal golden comparison (no update flag).
- `flutter build ios --simulator --debug --no-pub
  --dart-define=API_BASE_URL=http://localhost:8079`: passed. Installed and launched
  on booted iPhone 16 Pro Max. Observed live restaurant/address data in Home,
  light/dark rendering and Home -> account -> settings -> Home navigation.
  Restored the user's original dark preference and left Simulator on Home.
- Existing service destinations and actual catalog fields are retained.
- Removed the old combined Home presentation bodies; its import entry now exports
  focused components. Shared restaurant row and non-Home screens are retained
  because they still have consumers. No repository/API/business logic was changed.
- No commit, reset, backend change or unrelated cleanup performed.

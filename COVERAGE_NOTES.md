# Data coverage work (2026-10-07)

Tests only: production files under `lib/` are unchanged. No git commands were run.
Flutter SDK: `/Users/a/fvm/versions/3.32.8/bin/flutter` (3.32.8).

## Measurement

Line coverage sums `DA` records whose `SF` begins with the listed path; a line is
covered when its execution count is greater than zero. Generated `.g.dart` files
are included; no coverage exclusions or production annotations were added.

| Path | Before (covered / lines) | After (covered / lines) |
| --- | --- | --- |
| `lib/features/orders/data` | 630 / 1027 (61.34%) | 992 / 1027 (96.59%) |
| `lib/features/cart/data` | 49 / 263 (18.63%) | 247 / 263 (93.92%) |
| `lib/features/user_address/data` | 128 / 331 (38.67%) | 322 / 331 (97.28%) |

The pre-existing workspace `coverage/lcov.info` was stale (orders 54.47%,
cart 15.23%, addresses 38.67%). A fresh baseline was measured before introducing
these tests and matches the task's supplied missed-line counts.

## Validation environment and limitations

The exact `flutter test --coverage` command fails in the assigned checkout before
running tests because `pubspec.yaml:95` lists `.env`, which is absent. No `.env`
was added to the repository because the assigned edit scope is tests and this
notes file. Baseline and final full-suite coverage are measured in
`/private/tmp/app-cov-validation`, a filesystem copy of this checkout excluding
`.git`, build outputs and tool caches, with `.env.example` copied to `.env` only
inside that temporary directory. No private environment secrets were copied.

Commands:

- Baseline and final: `/Users/a/fvm/versions/3.32.8/bin/flutter test --coverage`
  from the temporary checkout.
- Focused: `/Users/a/fvm/versions/3.32.8/bin/flutter test --coverage --no-pub test/features/orders/data test/features/cart/data test/features/user_address/data`
  from the temporary checkout.
- Final analysis: `/Users/a/fvm/versions/3.32.8/bin/flutter analyze` from the
  actual assigned checkout. It exits 1 with three existing diagnostics:
  - `pubspec.yaml:95:7`: missing `.env` asset (warning).
  - `lib/features/home/presentation/widgets/map_widget.dart:31:12`: deprecated
    Mapbox `cameraOptions` (info).
  - `lib/features/orders/presentation/services/tracking_map_platform.dart:29:7`:
    deprecated Mapbox `cameraOptions` (info).
  No new test diagnostics remain. Final analysis reports exactly 3 issues and exits 1. These diagnostics cannot be removed within
  the tests-only scope; parent judgment or an expanded scope is required to meet
  the literal "analyze clean" criterion.

Evidence files:

- `/private/tmp/app-cov-baseline.log` (479 tests passed).
- `/private/tmp/app-cov-before.info` (fresh baseline lcov).
- `/private/tmp/app-cov-final.log` (610 tests passed, exit 0; 5m43s).
- `/private/tmp/app-cov-validation/coverage/lcov.info` (final lcov).
- `/private/tmp/app-cov-analyze-final.log` (actual checkout analysis).

## Behavior covered

- Real Dio/Retrofit request method, path, pagination query, serialized body and
  create-order `Idempotency-Key` header; successful, unsuccessful, null and
  malformed envelopes; 4xx/5xx responses; connection/send/receive timeouts;
  checkout 409 code/details preservation.
- Order and address datasource-to-repository pipelines and entity mapping;
  non-Exception datasource errors; delivery tracking REST and location stream
  filtering, connection/subscription failures, reconnect and cache behavior.
- DTO JSON round trips, nested item/voucher/price-change fields, coordinates,
  nullable defaults and timestamps; malformed refund identifiers/amounts/dates.
- Real temporary Hive storage, adapter round trips, reopen persistence, add/merge,
  update/remove/clear behavior, restaurant/livestream identity and repository
  storage failure mapping.

## Compatibility review and findings

Authority:
`/Users/a/Documents/private/delivery/backend_delivery/docs/platform/system/api/http-contract.json`.

The exercised order and address request methods/paths and serialized field names
match the manifest: `OrderController` history/detail/create/cancel,
`UserAddressController` list/detail/create/update/delete/default, and
`GET /api/deliveries/order/{orderId}`. Creation items, vouchers and preview request
fields match `CreateOrderRequest` and `CheckoutPreviewRequest`; rating JSON uses
`RestaurantRatingRequest` fields. No unsupported request path or body field was
found in these inspected APIs. Cart is local Hive storage and sends no HTTP
request.

Existing response/error behavior worth follow-up (preserved by these tests):

1. Address list parsing treats a non-list `data` value as an empty list. A success
   envelope containing a string therefore returns `Right([])`, although the
   backend declares `List<UserAddressResponse>`. Invalid list elements do fail.
2. `CacheException` is not explicitly handled by `mapExceptionToFailure`, so
   returned cart storage errors become `UnexpectedFailure`, rather than
   `CacheFailure`.
3. Address delete and order cancel use envelope status for success and accept a
   successful envelope with null data. Address delete ignores arbitrary data.
4. Address/delivery malformed payloads are wrapped as generic `Exception`, which
   maps to `UnexpectedFailure`; order malformed payloads map to
   `ValidationFailure`. HTTP 404 becomes `ServerFailure` through the datasource
   exception mapper, preserving current behavior.

No production compatibility fixes were made.

Final scope verification: content hashes of all 738 files under `lib/` match the
pre-edit snapshot. Five new test files and one expanded existing test file add
131 tests; six changed Dart files pass `dart format --output=none
--set-exit-if-changed` with zero formatting changes.

---

# Data/API coverage

Tests added for the five assigned paths; no production code was changed.
Flutter SDK: `/Users/a/fvm/versions/3.32.8/bin/flutter` (3.32.8).
Line counts include all `DA` records under each path, including generated DTO,
Retrofit, and Riverpod code; no coverage exclusions were added.

## Coverage evidence

| Path | Measured original-suite baseline (covered/total) | Measured after (covered/total) |
| --- | --- | --- |
| `lib/core/network` | 206/355 (58.03%) | 314/355 (88.45%) |
| `lib/features/support/data` | 1/124 (0.81%) | 121/124 (97.58%) |
| `lib/features/notification/data` | 155/235 (65.96%) | 220/235 (93.62%) |
| `lib/features/search/data` | 22/95 (23.16%) | 92/95 (96.84%) |
| `lib/features/entitlements/data` | 8/14 (57.14%) | 14/14 (100.00%) |

The coverage file initially present in this checkout was incomplete (network
156/301 and no support records), so it was not used as the comparable baseline.
The original-suite diagnostic run (excluding the six added test files) reproduced
all five supplied baseline counts exactly. Its LCOV snapshot is
`/tmp/app-cov-2-baseline-no-assets.info`; log:
`/tmp/app-cov-2-baseline-no-assets.log`. It finished with 444 passing tests and 33
failures, exit 1, under `--no-pub --no-test-assets --coverage -r expanded`.
The failing asset-free run supplies line-count evidence, not a green baseline.

Focused validation passed: **119 tests**, exit 0, using:

```sh
/Users/a/fvm/versions/3.32.8/bin/flutter test --no-pub --no-test-assets \
  --coverage --coverage-path=/tmp/app-cov-2-focused.info \
  test/features/support/data test/features/notification/data \
  test/features/search/data test/features/entitlements/data \
  test/core/network test/core/network/dio_client_debug_test.dart -r expanded
```

Log: `/tmp/app-cov-2-focused-final.log`. This run preceded the additional support
compatibility characterization test. The final support-only run passed all
22 tests, exit 0 (`/tmp/app-cov-2-support-final.log`), including that test and
exact assertions for `FieldValue.serverTimestamp()` / `FieldValue.increment(1)`.
Final full-suite evidence is recorded below.

The final full-suite diagnostic run finished with **535 passes and 33 failures**,
exit 1. The 33 failing test identities are identical to the original-suite run;
there are no additional failures. The additions contribute 91 passing tests.
All five coverage results in the table are confirmed by this full diagnostic run,
not just the focused run. Final LCOV is copied to `coverage/lcov.info`.

```sh
/Users/a/fvm/versions/3.32.8/bin/flutter test --no-pub --no-test-assets \
  --coverage --coverage-path=/tmp/app-cov-2-after-no-assets.info -r expanded
```

Log: `/tmp/app-cov-2-after-no-assets.log`. Before/after LCOV snapshots are
`/tmp/app-cov-2-baseline-no-assets.info` and
`/tmp/app-cov-2-after-no-assets.info`. Production file SHA-256 inventories before
and after validation match for every file under `lib/`.

## Behavior covered

- Support: canonical POST token route with no query/body, numeric/string principal
  validation, Firebase account switching, bad token/credential rejection, HTTP
  errors and timeout mapping, Firestore query clauses, conversation creation,
  message DTO fields and sender mapping, text validation, ownership/closed-chat
  checks, batch writes and unread/read counters, and optional close reasons.
  Firestore/Auth fakes capture SDK operations without credentials or emulators;
  they do not prove deployed Firestore rules, indexes, or server atomicity.
- Notification: GET/PUT/DELETE routes with no query/body, successful envelopes,
  strict DTO/entity mapping, negative counts, malformed/envelope failures,
  400/500 responses and timeouts mapped to `ServerFailure`, and DTO serialization.
- Search: GET paths and exact `q/page/size` query fields, custom pagination,
  nonempty restaurant/dish results, all DTO fields, malformed envelopes/items,
  400/503 failures, timeout propagation, and provider composition. Shipper model
  serialization is covered without inventing a shipper HTTP endpoint.
- Entitlements: both platforms' purchase/restore and repository refresh/submit
  remain unavailable, preserving the existing fail-closed boundary.
- Network: generic envelope/page serialization, provider/client lifecycle,
  configured Gateway origins, auth headers, sanitized logging, and a loopback
  WebSocket test exercising concurrent connection, raw/JSON messages, the real
  30-second heartbeat, reconnect after server close, disconnect, and disposal.

## Compatibility findings

Authority inspected:
`/Users/a/Documents/private/delivery/backend_delivery/docs/platform/system/api/http-contract.json`.

The tested search, notification, and Firebase token request methods/paths/query
names match the manifest. These notification mutations and Firebase chat-token
exchange send no body, matching their controller signatures. No incompatible
outgoing request path or body-field name was found in these data surfaces.

**Support token response validation gap:**
`FirebaseSupportRepository._ensureFirebaseSession` checks `data.token` and
`data.principalId` but does not check BaseResponse `status` or `message`. A failed
`status: 0` envelope containing otherwise valid token data still signs in and
creates a conversation. The test named
`compatibility: token parser currently ignores failed envelope status`
characterizes this existing behavior. Production code is deliberately unchanged;
a separate compatibility task should decide/enforce canonical envelope validation.
This is a response-validation finding, not an outgoing request mismatch.

## Validation limitations requiring parent takeover

The required default command `flutter test --coverage` exits 1 before executing
tests: `No file or variants found for asset: .env.`
Final exact-command log: `/tmp/app-cov-2-required-final.log`. The asset is declared at
`pubspec.yaml:95`, but `.env` is absent in this worktree. Creating that file or
changing the asset declaration is outside the assigned `test/` and notes scope.

`flutter analyze` exits 1 with three pre-existing, out-of-scope issues:

- `lib/features/home/presentation/widgets/map_widget.dart:31`: deprecated
  `cameraOptions`.
- `lib/features/orders/presentation/services/tracking_map_platform.dart:29`:
  deprecated `cameraOptions`.
- `pubspec.yaml:95`: missing `.env` asset.

Final analyzer log: `/tmp/app-cov-2-analyze-final.log`. No analyzer findings remain in the added tests. The Firestore fakes explicitly
suppress SDK sealed/immutable-interface warnings only in that test file.

Full-suite baseline and after runs use `--no-test-assets` as a diagnostic
workaround. This skips the asset bundle and causes existing widget tests to fail
on missing assets such as `shaders/ink_sparkle.frag`; it cannot establish a green
asset-dependent full suite. The parent must provide the normal local `.env`
fixture and resolve or separately accept the existing analyzer issues, then
rerun the required commands. This task must not be marked DONE while those
acceptance criteria remain unmet.

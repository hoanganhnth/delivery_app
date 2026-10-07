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

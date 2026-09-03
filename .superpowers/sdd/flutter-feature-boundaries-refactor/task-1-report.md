# Task 1 implementation report — baseline and design-system authority

## Status

`DONE_WITH_CONCERNS`

Implementation commit: `76e482a` (`refactor(ui): centralize theme authority`)

## Outcome

- `lib/core/design_system/` is now the implementation authority for customer
  theme construction, colors, typography, dimensions, semantic colors, and
  persisted theme state.
- Every existing `lib/core/theme/*.dart` public path remains available as a
  compatibility export. `core/theme/theme.dart` remains the bootstrap-facing
  compatibility barrel.
- The unused legacy static color API formerly implemented in
  `lib/core/constants/app_color.dart` is also implemented under
  `core/design_system/compatibility/`; its old path remains an export.
- Ocean is no longer a selectable `AppThemeType`. A persisted `app_theme=ocean`
  value resolves to Light immediately and is rewritten to `light` in
  `SharedPreferences`.
- Theme typography and border widths touched in this task now use logical
  pixels. `flutter_screenutil`, `.sp`, and `.w` were removed from the moved
  theme implementation only. Existing ScreenUtil use elsewhere was deliberately
  left for later migration tasks.
- No pilot screen, shell, or navigation behavior was changed.

## Authority and compatibility details

Canonical implementation files:

- `lib/core/design_system/theme/app_colors.dart`
- `lib/core/design_system/theme/app_text_styles.dart`
- `lib/core/design_system/theme/app_theme.dart`
- `lib/core/design_system/theme/theme_extensions.dart`
- `lib/core/design_system/theme/theme_provider.dart`
- `lib/core/design_system/theme/theme_provider.g.dart`
- `lib/core/design_system/foundations/app_dimensions.dart`
- `lib/core/design_system/compatibility/legacy_app_colors.dart`

Updated barrels and compatibility paths:

- `lib/core/design_system/design_system.dart` exports the canonical UI tokens,
  theme model, and extensions. The Riverpod provider is intentionally not
  re-exported from this UI barrel because its legacy notifier class is named
  `Theme`, which conflicts with Flutter Material's `Theme` in pure views.
- `lib/core/theme/theme.dart` exports the canonical UI barrel and the provider
  compatibility path for existing bootstrap code.
- `lib/core/theme/app_colors.dart`, `app_dimensions.dart`,
  `app_text_styles.dart`, `app_theme.dart`, `theme_extensions.dart`, and
  `theme_provider.dart` now contain exports only.
- `lib/core/constants/app_color.dart` now contains an export only.

## Plus Jakarta Sans decision

The repository has no checked-in Plus Jakarta Sans `.ttf`/`.otf` source. The
only discovered font files were third-party Roboto assets inside generated
iOS/macOS Pods, which are not an appropriate source and were not copied.

Accordingly, this task did not add or download a font asset and did not mutate
`pubspec.yaml`. The canonical theme now consistently declares the correct
family name, `Plus Jakarta Sans`, across `ThemeData` and `AppTextStyles`, with
offline-safe platform sans-serif fallbacks (`Arial`, `sans-serif`). This avoids
introducing a runtime font download dependency. Exact Plus Jakarta Sans glyphs
will require a separately approved, appropriately licensed font file to be
checked into the repository and declared under `flutter.fonts`.

## TDD evidence

Red phase:

- Command: `.fvm/flutter_sdk/bin/flutter test --no-pub test/core/theme/theme_provider_test.dart`
- Result: exit `1`; canonical `design.AppTheme`, `AppThemeType`, and
  `AppTextStyles` were not yet exported, so the new contract tests failed to
  compile as expected.

Green phase:

- Command: `.fvm/flutter_sdk/bin/flutter test --no-pub test/core/theme/theme_provider_test.dart`
- Result: exit `0`; `7` tests passed.
- Covered contracts: synchronous stored-theme initialization, toggle/persist,
  write-failure visible state, old/new import compatibility, Light/Dark-only
  choices, logical-pixel typography, and `ocean -> light` persistence migration.

Consumer regression proof:

- Command: `.fvm/flutter_sdk/bin/flutter test --no-pub test/core/theme/theme_provider_test.dart test/features/settings/application/settings_view_model_test.dart test/features/settings/presentation/screens/settings_screen_test.dart`
- Result: exit `0`; `11` tests passed.

## Baseline capture

Pre-change worktree state contained user-owned changes in Cart, Catalog, Main,
restaurants DI, the catalog view test, and an untracked restaurants DI test
directory. Those paths were recorded before edits and preserved.

- Focused pre-change theme test:
  `.fvm/flutter_sdk/bin/flutter test --no-pub test/core/theme/theme_provider_test.dart`
  — exit `0`, `3` tests passed.
- Focused dirty catalog test:
  `.fvm/flutter_sdk/bin/flutter test --no-pub test/features/catalog/presentation/views/catalog_home_view_test.dart`
  — exit `0`, `2` tests passed. This superseded the stale ledger note that the
  dirty constructor mismatch was still present.
- Pre-change analyzer:
  `.fvm/flutter_sdk/bin/flutter analyze --no-pub`
  — exit `1`, exactly `10` `dangling_library_doc_comments` info diagnostics,
  with no warning/error diagnostics.
- A pre-change full-suite run was started, but its terminal output was not
  retained by the command session; it is not claimed as baseline proof. The
  complete post-change full-suite result is recorded below.
- Screenshot baseline discovery found no `matchesGoldenFile`, golden test,
  screenshot harness, or checked-in customer screenshot artifact. The repo has
  reference HTML in `docs/stitch_designs/`, not executable screenshot proof.
  No screenshot was fabricated because pilot screens and navigation are outside
  Task 1.

## Final validation

- `.fvm/flutter_sdk/bin/dart run build_runner build --delete-conflicting-outputs --build-filter=lib/core/design_system/theme/theme_provider.g.dart`
  — exit `0`; Riverpod output generated at its canonical location.
- `.fvm/flutter_sdk/bin/flutter analyze --no-pub lib/core/design_system lib/core/theme test/core/theme`
  — exit `0`; no issues.
- `.fvm/flutter_sdk/bin/flutter test --no-pub`
  — exit `0`; `347` tests passed.
- `.fvm/flutter_sdk/bin/flutter analyze --no-pub`
  — exit `1`; the same `10` baseline info diagnostics remain, with no new
  diagnostics and no warning/error diagnostics.
- `.fvm/flutter_sdk/bin/dart run tool/verify_architecture.dart --strict`
  — exit `0`; strict architecture guard passed.
- `git diff --check` — exit `0`.
- Staged pre-commit inspection listed only Task 1 paths; no Cart, Catalog,
  Main, dirty restaurants DI, or untracked test path was staged.

## Preserved dirty worktree after commit

`git status --short` after commit `76e482a` contained only:

- `lib/features/cart/presentation/pages/cart_page.dart`
- `lib/features/cart/presentation/views/cart_view.dart`
- `lib/features/catalog/application/catalog_home_state.dart`
- `lib/features/catalog/presentation/pages/catalog_home_page.dart`
- `lib/features/catalog/presentation/views/catalog_home_view.dart`
- `lib/features/main/presentation/pages/main_screen.dart`
- `lib/features/restaurants/di/catalog_browse_port_provider.dart`
- `test/features/catalog/presentation/views/catalog_home_view_test.dart`
- untracked `test/features/restaurants/di/`

## Concerns / follow-up

1. Exact Plus Jakarta Sans rendering is not bundled because no appropriate
   checked-in source exists. Platform sans-serif fallback is intentional and
   safe, but visual goldens should only be approved after a licensed font asset
   is supplied.
2. The repository still has no automated screenshot baseline. Task 2's pilot
   screen/golden gate should establish it before broader rollout.
3. Full analyzer remains non-zero because of the same ten pre-existing info
   diagnostics captured before this task; Task 1 introduced none.
4. Legacy ScreenUtil usage remains outside the files owned by this task, as
   required. It must be removed incrementally when those files are migrated.

## Review fix round 1

Status after review: `DONE_WITH_CONCERNS`

Review-fix commit:
`e1d0a240446181a1b4371fbf0b648b910d0315f4`
(`fix(ui): preserve theme compatibility and bundle font`)

### Findings and fixes

1. **The legacy `core/theme/theme.dart` barrel did not preserve its exact
   public surface.** Re-exporting the canonical design-system barrel changed
   `AppSpacing` resolution from the legacy scale (`xs=4`, `sm=8`) to the new
   scale (`xs=8`, `sm=12`) and hid legacy dimension members. The compatibility
   barrel now explicitly exports its six historical theme paths, which resolve
   the original spacing values and members while still forwarding theme
   implementations to the canonical design system. A dedicated compatibility
   test protects both the old and new spacing contracts.
2. **The fire-and-forget `ocean -> light` preference rewrite could surface an
   unhandled asynchronous error.** `SharedPreferencesThemeStorage` now exposes
   `migrationComplete`, catches rewrite failures without rolling back the
   immediately visible Light theme, and retries the canonical rewrite on a
   later read. Writer injection makes both successful and failed persistence
   paths deterministic in tests.
3. **The Task 1 brief required Plus Jakarta Sans to be bundled, but the initial
   implementation only declared the family and fallbacks.** Static weights
   400, 500, 600, 700, and 800 are now checked in, registered in
   `pubspec.yaml`, and accompanied by SIL OFL 1.1 plus pinned-source provenance.
   `AppTextStyles.display` uses `w800`, the maximum upstream weight, instead of
   requesting an unavailable `w900` face.

The review regression tests were red against commit `76e482a`: the legacy
compatibility assertions exposed the spacing/barrel mismatch, the migration
tests lacked an observable failure-safe completion boundary, and the font asset
test reported the required files and `pubspec.yaml` registrations as missing.
After the fixes, the same review slice is green.

### Review validation

- Focused review tests (`theme_provider_test.dart`,
  `theme_compatibility_test.dart`, and `font_assets_test.dart`) — exit `0`;
  `12/12` tests passed.
- Full Flutter suite — exit `0`; `352/352` tests passed.
- Focused analyzer over the design-system/theme implementation and tests —
  exit `0`; no issues.
- Full analyzer — no warning/error diagnostics and no new diagnostics; it
  retains exactly the same `10` pre-existing
  `dangling_library_doc_comments` info diagnostics.
- `.fvm/flutter_sdk/bin/dart run tool/verify_architecture.dart --strict` —
  exit `0`.
- `.fvm/flutter_sdk/bin/flutter build bundle --debug --no-pub` — exit `0`.
- Generated `build/flutter_assets/FontManifest.json` contains the registered
  Plus Jakarta Sans weights `400`, `500`, `600`, `700`, and `800`.
- `flutter pub get` completed successfully with no `pubspec.lock` change.
- `git diff --check` passed before the review-fix commit.

### Font source, integrity, and license

- Official upstream: `tokotype/PlusJakartaSans`, pinned commit
  `18d1cd2f7ea10481919d2f05c1f7064b7307fc26`.
- Cross-reference: Google Fonts `ofl/plusjakartasans` metadata.
- License: SIL Open Font License 1.1, retained as
  `assets/fonts/plus_jakarta_sans/OFL.txt`.
- Upstream Git blob hashes matched the bundled binaries:
  Regular `cb874458c3911fcb7a12da70f66e4154863c9841`, Medium
  `5d8dd8ab476e4bc9766af41d9ee0e183da2c15fe`, SemiBold
  `c12d4b0e72bde4d78af22aa73184024d2495bef3`, Bold
  `2d49642350842c27fc88ff90d6445eeda1766f7e`, and ExtraBold
  `2ae35660dc8a2cc1169e7de96b61cb12c887207d`.
- The web connector returned `401` during source lookup, so verification used
  the official GitHub APIs and raw URLs pinned to the upstream commit.

**Supersession:** the earlier “Plus Jakarta Sans decision” and concern 1 above
describe the state of the initial commit only. They are no longer current:
commit `e1d0a24` bundles and registers the approved, licensed font assets. The
remaining concerns are the ten pre-existing analyzer infos, the absent
screenshot/golden harness, and intentionally deferred ScreenUtil migration
outside Task 1.

## Review fix round 2

Status after scoped re-review: `DONE_WITH_CONCERNS`

Review-fix commit:
`9f90f85e43a426ca77222768cb6268cbb517653b`
(`fix(ui): retry rejected theme migration writes`)

### Finding and fix

`ThemePreferenceWriter` returns `Future<bool>`, but the first review fix treated
any normally completed future as a successful Ocean migration. A writer can
update the in-memory SharedPreferences cache to `light` and still return
`false` because durable persistence failed. The cached value then hid the
failure, so a later read did not retry.

`SharedPreferencesThemeStorage` now maintains explicit pending and in-flight
legacy-migration state independently of the cached preference. Only a `true`
writer result clears pending state. A `false` result or exception leaves the
visible theme safely on Light and keeps the migration pending for the next
read; the in-flight guard prevents duplicate concurrent writes.

The deterministic regression test simulates the important edge case by
updating the cache to `light` while the first writer result is `false`, then
returning `true` on the retry. It also confirms that a third read does not write
again after success. The existing exception-path test remains green.

### TDD and validation evidence

- RED:
  `.fvm/flutter_sdk/bin/flutter test --no-pub test/core/theme/theme_provider_test.dart --plain-name 'false ocean rewrite result remains pending and retries'`
  — exit `1`; `Expected: <2>`, `Actual: <1>` at
  `theme_provider_test.dart:141`, proving the cached `light` value suppressed
  the required retry.
- GREEN provider slice:
  `.fvm/flutter_sdk/bin/flutter test --no-pub test/core/theme/theme_provider_test.dart`
  — exit `0`; `9/9` tests passed, including `false` and exception failures.
- Full review slice:
  `.fvm/flutter_sdk/bin/flutter test --no-pub test/core/theme/theme_provider_test.dart test/core/theme/theme_compatibility_test.dart test/core/design_system/font_assets_test.dart`
  — exit `0`; `13/13` tests passed.
- Full Flutter suite:
  `.fvm/flutter_sdk/bin/flutter test --no-pub`
  — exit `0`; `353/353` tests passed.
- Focused analyzer:
  `.fvm/flutter_sdk/bin/flutter analyze --no-pub lib/core/design_system/theme/theme_provider.dart test/core/theme/theme_provider_test.dart`
  — exit `0`; no issues.
- Full analyzer:
  `.fvm/flutter_sdk/bin/flutter analyze --no-pub`
  — exit `1`; exactly the same `10` pre-existing
  `dangling_library_doc_comments` info diagnostics remain, with no warnings,
  errors, or new diagnostics.
- Strict architecture guard:
  `.fvm/flutter_sdk/bin/dart run tool/verify_architecture.dart --strict`
  — exit `0`; passed.
- Formatting: `.fvm/flutter_sdk/bin/dart format` reported both touched files
  already formatted (`0 changed`).
- Pre-commit `git diff --cached --check` and scoped secret scan passed. The
  staged diff contained only the migration implementation and its regression
  test; all user-owned dirty Cart, Catalog, Main, restaurants DI, and catalog
  test paths remained unstaged.

## Review fix round 3

Status after scoped re-review: `DONE_WITH_CONCERNS`

### Finding and fix

Round 2 correctly kept failed Ocean migrations pending, but `writeTheme()` still
awaited `_migrationComplete` before clearing that pending state. Because Dart
`await` yields even for an already completed future, an explicit user
`writeTheme(AppThemeType.dark)` could be followed immediately by `readTheme()`
while `_legacyThemeMigrationPending` was still `true`. That read returned Light
again and restarted the legacy `light` rewrite, which violated the user-choice
precedence expected by the review.

`SharedPreferencesThemeStorage` now treats an explicit theme write as the
authority boundary for legacy migration state. It clears the pending migration
flag synchronously, records a temporary explicit-theme override only while a
legacy migration is being superseded, then persists the user-selected theme
after any in-flight Light rewrite settles. `readTheme()` consults that override
first, so an immediate read after `writeTheme(dark)` returns Dark and does not
queue another Light migration. The existing `false` and exception retry
behavior for un-superseded Ocean migrations remains unchanged.

### TDD and validation evidence

- RED:
  `.fvm/flutter_sdk/bin/flutter test --no-pub test/core/theme/theme_provider_test.dart`
  — exit `1`; the new regression
  `explicit dark write immediately supersedes a failed pending ocean migration`
  failed with `Expected: AppThemeType.dark` and
  `Actual: AppThemeType.light` at `theme_provider_test.dart:201`, proving a
  pending failed migration could still win a same-instance follow-up read.
- GREEN provider slice:
  `.fvm/flutter_sdk/bin/flutter test --no-pub test/core/theme/theme_provider_test.dart`
  — exit `0`; `11/11` tests passed, including the new failed-`false`
  supersession regression and the existing exception-path regression.
- Focused analyzer:
  `.fvm/flutter_sdk/bin/flutter analyze --no-pub lib/core/design_system/theme/theme_provider.dart test/core/theme/theme_provider_test.dart`
  — exit `0`; no issues.
- Formatting:
  `.fvm/flutter_sdk/bin/dart format lib/core/design_system/theme/theme_provider.dart test/core/theme/theme_provider_test.dart`
  — exit `0`; `Formatted 2 files (0 changed)`.
- Scoped diff hygiene:
  `git diff --check -- lib/core/design_system/theme/theme_provider.dart test/core/theme/theme_provider_test.dart`
  — exit `0`; no whitespace or conflict-marker issues.
- Scope control:
  the only intended Task 1 edits in this round are
  `lib/core/design_system/theme/theme_provider.dart`,
  `test/core/theme/theme_provider_test.dart`, and this report file. User-owned
  dirty Cart, Catalog, Main, restaurants DI, and catalog test paths remain
  outside the staged commit for this round.

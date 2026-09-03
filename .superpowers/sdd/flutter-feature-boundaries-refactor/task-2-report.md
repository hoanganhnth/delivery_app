# Task 2 implementation report — primitives and pilot screens

## Status

`DONE_WITH_CONCERNS`

Implementation commits:

- `8e9097db710371424dcf838d0ed741f3532f2414`
  (`feat(ui): add accessible design system primitives`)
- `b4775248a6ceca0e97c607abe503fdbf77fee902`
  (`fix(ui): preserve legacy app image export`)
- `ffe39cc02ea6ab85a54f41922fb6339627534dd9`
  (`feat(ui): migrate customer pilot screens`)

## Outcome

- Added token-driven reusable primitives under
  `lib/core/design_system/components/`: buttons, icon buttons, fields/search,
  surfaces/cards, sections/headings, chips/badges, app bars, content images,
  state feedback, and sticky actions.
- Preserved legacy imports through `core/widgets/amber_widgets.dart`. The
  existing `AmberSearchBar` public API is unchanged and its implementation now
  composes canonical design-system fields and buttons.
- Migrated the Home/Catalog, Restaurant detail, and Checkout pilot surfaces to
  the canonical tokens in Light and Dark themes and Vietnamese and English
  locales.
- Split large presentation blocks into feature-owned components:
  `catalog_home_components.dart`,
  `catalog_restaurant_detail_parts.dart`, and `checkout_components.dart`.
- Preserved Page/View separation, typed intent callbacks, routes, existing
  widget keys, and checkout/catalog behavior contracts.
- Removed `ScreenUtil`, raw hexadecimal colors, heavy blur, and emoji/star text
  from the touched pilot presentation files.
- Added VI/EN ARB strings and regenerated the checked-in localization output.
- Added an accessibility/layout matrix at 360 and 390 logical pixels and three
  representative golden baselines.

## TDD evidence

Baseline:

- The pre-change pilot view slice passed `15/15` tests.

Red phase:

- `test/core/design_system/component_primitives_test.dart` failed to compile
  before implementation because the requested primitive APIs did not exist.
- The pilot accessibility/layout tests failed against the old screens because
  visible Vietnamese copy was hard-coded and layout dimensions depended on
  `ScreenUtil` rather than logical-pixel design tokens.

Green phase:

- Primitive contract tests passed `4/4`.
- The focused primitive, pilot behavior, and accessibility slice passed
  `23/23`.
- The golden suite passed `3/3` after baseline generation and again under
  normal comparison.
- The final combined golden/accessibility command passed `8/8`.

The primitive tests cover disabled/loading semantics, named 48 logical-pixel
icon targets, field labels and callbacks, surface/section/chip/badge
composition, image fallback semantics, feedback actions, and sticky actions.
The pilot tests additionally assert localized copy, semantic action labels,
safe-area/sticky-action placement, and layout stability across both themes,
both locales, and the two target widths.

## Golden review

Checked-in representative baselines:

- Home — 360 px, Light, Vietnamese
- Restaurant detail — 390 px, Dark, English
- Checkout — 390 px, Light, Vietnamese

The PNGs were inspected for spacing, color, clipping, safe areas, and sticky
action placement. Flutter's standard test renderer rasterizes the bundled font
as deterministic block glyphs in this environment, so the images are not
appropriate proof of exact glyph appearance. Localized text correctness is
covered independently by widget and semantics assertions.

## Final validation

- `.fvm/flutter_sdk/bin/flutter test --no-pub` — exit `0`; `366/366` tests
  passed.
- Combined golden/accessibility tests — exit `0`; `8/8` tests passed.
- Focused analyzer over the touched implementation and tests — exit `0`; no
  issues.
- `.fvm/flutter_sdk/bin/flutter analyze --no-pub` — exit `1`; exactly the same
  `10` pre-existing `dangling_library_doc_comments` info diagnostics remain,
  with no warning/error or new diagnostic.
- `.fvm/flutter_sdk/bin/dart run tool/verify_architecture.dart --strict` — exit
  `0`; strict architecture guard passed.
- `.fvm/flutter_sdk/bin/flutter build bundle --debug --no-pub` — exit `0`.
- `git diff --check` and staged `git diff --cached --check` — exit `0`.
- Scoped scans found no `ScreenUtil`, `.w`/`.h`, raw `Color(0x...)`,
  `BackdropFilter`/`ImageFilter`, or star emoji in the touched pilot UI files.
- Staged pre-commit inspection contained only Task 2-owned paths. The two
  overlapping Home files used index-only staging so user-owned address changes
  remained outside the commit.

## Preserved dirty worktree after commit

The following pre-existing user-owned paths remain unstaged and unchanged by
the Task 2 commits:

- `lib/features/cart/presentation/pages/cart_page.dart`
- `lib/features/cart/presentation/views/cart_view.dart`
- `lib/features/catalog/application/catalog_home_state.dart`
- `lib/features/catalog/presentation/pages/catalog_home_page.dart`
- `lib/features/catalog/presentation/views/catalog_home_view.dart`
- `lib/features/main/presentation/pages/main_screen.dart`
- `lib/features/restaurants/di/catalog_browse_port_provider.dart`
- `test/features/catalog/presentation/views/catalog_home_view_test.dart`
- untracked `test/features/restaurants/di/`

In the two overlapping Home files, the remaining diff contains only the
user-owned optional `deliveryAddress` constructor/state wiring and its existing
assertion. Task 2's locale stabilization is committed separately from those
hunks.

## Concerns / follow-up

1. Exact test-font glyph appearance is not reviewable from the current golden
   PNGs; widget/semantics assertions prove localized content, while the goldens
   prove geometry and styling. A platform screenshot review can supplement
   this gate if exact font rasterization becomes a release requirement.
2. The full analyzer intentionally remains non-zero due to the same ten
   baseline info diagnostics; Task 2 introduced no new analyzer diagnostics.
3. This task gates the remaining rollout. It does not migrate other customer
   surfaces or change application capabilities, routing, or backend contracts.

## Review fix — restore restaurant sticky-cart total

Review-fix commit:
`92e9eca7a7796950aff938488c22019681f02586`
(`fix(ui): restore restaurant cart total`)

The pilot migration retained `CatalogRestaurantCartButton.totalAmount` but
dropped the value from the sticky cart CTA. The button now displays the total
beside the item count when the cart is non-empty and includes both values in
its semantic label. The empty state, callback behavior, `AppStickyAction`
boundary, and `AppButton` primitive remain unchanged.

TDD and focused validation:

- RED: the focused restaurant widget test failed because
  `Xem giỏ hàng (1) · 50000 ₫` was absent.
- GREEN: all `3/3` restaurant-detail tests passed, including visible and
  semantic-label assertions for the restored total.
- The affected Restaurant Dark/English golden was regenerated, visually
  inspected, and passed normal comparison (`1/1`).
- Formatter reported the production component unchanged; `git diff --check`
  and staged diff inspection passed.

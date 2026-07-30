# Testing strategy

The customer app uses Riverpod overrides as its dependency-injection boundary.
Tests should replace repositories, storage, push/deep-link, location, socket and
map ports; they must not initialize Firebase, Mapbox, SharedPreferences, Hive or
device plugins merely to exercise a use case.

Theme persistence, rating submission, tracking timers and Mapbox directions are
also ports. Production adapters are assembled by `AppDependencies`; widget and
provider tests override them with in-memory storage, request recorders and a
manual scheduler. A widget that starts tracking owns a cancellable lease and
must prove teardown and late-response fencing.

Splash delay and the tracking map canvas/service are injectable as well. Host
tests exercise splash retry, map controls, marker/route calls and disposal with
plain fakes; only the platform adapter constructs `MapWidget`. Auth form tests
cover validation, loading/single-submit, register-to-login ordering and social
identity ports on a phone-sized viewport.

Use `test/support/app_harness.dart` for localized widget and router tests. Keep
canonical DTO/entity builders under `test/support/` and prefer controllable
fakes that record calls over mocks between application layers.

Validation commands:

```sh
fvm flutter analyze
fvm flutter test
fvm flutter test --coverage
fvm dart run tool/coverage_policy.dart
```

Coverage excludes generated files, generated localization, Firebase options
and unreachable platform glue. Coverage is a regression guard; completion is
measured against the use-case/action matrix in the system execution plan.

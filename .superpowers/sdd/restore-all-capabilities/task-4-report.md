# Task 4 Report — VNPay Sandbox Payment Boundary

Date: 2026-08-27

## Outcome

Task 4 adds a strictly gated VNPay sandbox/return boundary. It does **not**
enable online checkout or alter the COD order flow. Gateway exposes only
`POST /api/settlement/payments/create` and
`GET /api/settlement/payments/ref/{paymentRef}` when
`PAYMENT_CLIENT_API_ENABLED=true`; its default is false in application,
Compose, and Kubernetes runtime configuration. Settlement processing also
remains false by default.

The present database/order model cannot safely support customer payment:
`payment_orders` lacks a customer principal owner and Order validation remains
COD-only. The new customer adapter derives the USER identity from the verified
JWT and returns explicit 409 errors for create and lookup rather than accepting
an entity/user ID, creating a payment, or exposing an arbitrary status. It has
no unconditional success or exception-only fallback; an incomplete future
service implementation still receives the same 409 fail-closed response.

## Files changed

### backend_delivery

- `api-gateway/.../GatewayRouteConfig.java` and payment route tests: independent
  exact-method Gateway gate; callback, IPN, fake confirm, provider list, and
  broad status routes remain unavailable.
- `settlement-service/.../CustomerPaymentController.java` and
  `CustomerPaymentBoundaryService.java`: JWT-scoped customer boundary that
  rejects unsupported order/ownership cases without caller-controlled payer
  data.
- `settlement-service/.../PaymentController.java`: legacy create/status/provider
  handlers moved under `/internal`; no Gateway route was added for them.
- Settlement tests: customer access/fail-closed fallback, missing VNPay
  credentials, and idempotent success/cancel callback side effects.
- Runtime/default config and canonical HTTP/settlement documentation: client and
  processing flags remain false in production-like manifests.

### delivery_app

- `lib/core/config/runtime_config.dart`:
  `VNPAY_PAYMENT_ENABLED` build-time flag, default false.
- `lib/features/payments/`: clean data/domain/application/presentation boundary
  using the authenticated Gateway Dio; no direct service URL or internal token.
- `PaymentReturnCoordinator`: strict expected-return URL plus VNPay reference
  and two-digit provider status validation; terminal state is set before the
  one canonical status refresh. WebView navigation and deep-link entry call the
  same coordinator.
- `PaymentReturnPage` and `PaymentReturnView`: native WebView is not created
  when the build flag is off, and the page never creates/clears an order or
  declares success from the callback URL.
- Focused tests cover canonical success, cancellation/failure, duplicate
  callback, malformed callback, refresh failure, Gateway reference parsing,
  direct disabled-page behavior, and unchanged COD checkout behavior.

## Root causes and contract decisions

1. The legacy payment controller trusted client-supplied entity/purpose/amount
   and its table did not persist a customer principal. It could not safely serve
   customer callers. The adapter therefore accepts only an order ID and derives
   the authenticated actor; it deliberately returns
   `CUSTOMER_ORDER_PAYMENT_UNSUPPORTED` or
   `CUSTOMER_PAYMENT_OWNERSHIP_UNSUPPORTED` (409) pending a durable
   order-payment ownership design.
2. The old Flutter WebView created/cleared a COD order from a callback URL. The
   restored flow treats `vnp_ResponseCode` solely as a trigger to refresh the
   canonical Gateway status, exactly once. A URL cannot yield a success state
   by itself; duplicate WebView/deep-link deliveries and refresh errors are
   terminal and non-success outcomes.
3. The order-service COD validation was intentionally not changed. No `ONLINE`
   method, paid-order event consumer, fake confirmation, or VNPay IPN route was
   opened.

## TDD and validation evidence

Red tests observed before implementation:

- `mvn -pl api-gateway -Dtest=PaymentClientGatewayRouteEnabledTest test` —
  failed because `settlement-service-customer-payment` was absent.
- `mvn -pl settlement-service -Dtest=CustomerPaymentBoundaryServiceTest test`
  after installing the local `identity-contracts` artifact — failed compilation
  because `CustomerPaymentBoundaryService` did not exist.
- `fvm flutter test test/features/payments/application/payment_return_coordinator_test.dart test/features/payments/presentation/payment_return_view_test.dart`
  — failed because the payment boundary classes did not exist.
- `fvm flutter test test/features/payments/data/customer_payment_gateway_test.dart`
  — failed because the Gateway adapter did not exist.
- `mvn -pl settlement-service -Dtest=CustomerPaymentControllerTest test` —
  failed with the old unconditional `IllegalStateException`; the replacement
  fallback now returns 409.

Passing focused proof:

```text
mvn -pl api-gateway -Dtest=GatewayRouteSecurityTest,PaymentClientGatewayRouteEnabledTest test
Result: 14 tests passed.

mvn -pl settlement-service -Dtest=CustomerPaymentBoundaryServiceTest,CustomerPaymentControllerTest,PaymentCallbackIdempotencyTest test
Result: 8 tests passed.

fvm flutter test test/features/payments test/features/cart/presentation/views/checkout_view_test.dart test/features/cart/presentation/providers/checkout_capability_contract_test.dart
Result: 22 tests passed.

fvm flutter analyze lib/core/config/runtime_config.dart lib/core/constants/api_constants.dart lib/features/payments test/features/payments
Result: no issues found.

docker compose -f docker-compose.yml config -q
Result: passed.

git diff --check (each repo)
Result: passed.
```

## Fix round 2 — shared payment return coordinator

Review found that `routerProvider` used `paymentReturnCoordinatorProvider`,
but `PaymentReturnPage` constructed a second `PaymentReturnCoordinator` from the
status refresher. The page now reads the provider-backed coordinator directly;
the provider remains the sole source of the canonical configured
`RuntimeConfig.vnpayReturnUri`, and the page no longer accepts a caller-supplied
return URI.

The coordinator test now sends the same valid callback through WebView and
app-link entry points concurrently and proves one terminal outcome is a
duplicate and only one Gateway status refresh occurs. The disabled page test
also observes initialization of `paymentReturnCoordinatorProvider`, proving the
presentation boundary uses the same provider-backed instance used by router
composition. Callback validation and the default-off WebView guard are
unchanged.

Fix-round-2 validation:

```text
fvm flutter test test/features/payments/presentation/payment_return_page_test.dart
Result: 1 test passed (after the expected red compile failure before page wiring).

fvm flutter test test/features/payments
Result: 13 tests passed.

fvm flutter analyze lib/core/config/runtime_config.dart lib/core/routing/providers/router_provider.dart lib/features/payments test/features/payments
Result: no issues found.

git diff --check
Result: passed.
```

## Commits

- `backend_delivery`: `716985bc30c032d23437d10f0940b898dac161b3`
  (`feat(payment): add gated customer sandbox boundary`).
- `delivery_app`: the focused Task 4 commit contains this report and is supplied
  in the task completion response.

## Remaining concerns

- This is intentionally not a real customer online-payment or paid-order E2E:
  a future capability needs a principal-owned payment record, authoritative
  order-payment lifecycle, signed provider callback/IPN/reconciliation proof,
  and a reviewed user entry point before it can be enabled.
- The provider credential test intentionally logs the expected missing-credential
  failures while proving they fail closed.
- Maven reports an existing duplicate `identity-contracts` dependency warning in
  `delivery-service`; it is unrelated to this task. `identity-contracts` was
  installed locally only so Settlement's focused test module could resolve its
  normal workspace dependency.

## Fix round 1 — production deep-link wiring and HTTP contract regeneration

The app's production `routerProvider` now composes the existing
`IDeepLinkService` with the payment-owned handler. A matching configured
`VNPAY_RETURN_URI` is consumed by `PaymentReturnCoordinator.handleDeepLink`; the
handler remains inert for payment callbacks while `VNPAY_PAYMENT_ENABLED` is
false, and non-payment links retain the existing router fallback. The same
coordinator instance remains the terminal/idempotent boundary, so a WebView and
app-link copy cannot cause a second refresh.

The reachable composition test reads the real `routerProvider`, verifies that
the app's deep-link service is initialized with the payment handler, and proves
the default-off callback performs no refresh. The focused payment wiring suite
also covers enabled callback forwarding and non-payment fallback. Existing
coordinator tests explicitly cover success, cancel/failure, duplicate delivery,
malformed callbacks, and refresh failure; the payment return view tests cover
the flag-off deep-link/WebView boundary.

The backend HTTP contract was regenerated with the canonical generator after
bringing the dirty inventory's six existing simulator/delivery rows into its
declared count (220 → 226). The generated manifest/catalog now contains the
customer boundary mappings, current `/internal` legacy PaymentController
mappings, and source-derived callback/IPN/fake operations without treating them
as Gateway routes. The operator example now includes
`PAYMENT_CLIENT_API_ENABLED=false`; processing and client route flags remain
false in all checked-in defaults.

The inventory count adjustment and its pre-existing simulator/delivery rows
remain unstaged in `backend_delivery` so unrelated working-tree work is not
committed; the generator check above was run against that current worktree.

Fix-round validation:

```text
fvm flutter test test/features/payments/application/payment_deep_link_wiring_test.dart
Result: 4 tests passed (after an intentional red compile failure for the new fallback/provider assertions).

fvm flutter test test/features/payments test/features/cart/presentation/views/checkout_view_test.dart test/features/cart/presentation/providers/checkout_capability_contract_test.dart
Result: 26 tests passed.

fvm flutter analyze lib/core/config/runtime_config.dart lib/core/routing/providers/router_provider.dart lib/features/payments test/features/payments
Result: no issues found.

node docs/platform/system/api/generate-http-contract.mjs --write
node docs/platform/system/api/generate-http-contract.mjs --check
Result: wrote and checked 226 operations and 202 source schemas.

git diff --check (each repo)
Result: passed.
```

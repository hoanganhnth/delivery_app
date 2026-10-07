# Customer app API compatibility

Authority: backend `main` 9aed3cf, `http-contract.json` and `public-edge-manifest.json`, copied without modifications into `contracts/backend/`. Controller/DTO source under infrastructure wins over generated metadata. No backend edits.

## Inventory and verdicts

All **54 explicit backend HTTP call sites** are listed below, including duplicate refresh/search routes in separate clients. Paths include the configured Gateway `/api` prefix. Retrofit-generated `fetch` operations implement their declarations; auth `dio.fetch(requestOptions)` replays the original request unchanged and adds no route. Path variables are bound from the corresponding method arguments; numeric IDs are JSON integers/Java Longs, livestream IDs UUID strings, and voucher codes/payment references URI-encoded strings.

Every listed route exists and is public in the snapshot. Gateway payment and livestream routes are feature-gated, so exposure does not imply that a deployment enables them. Verdicts retain the original mismatch and the final resolution. No NOT_PUBLIC or missing controller route was found. The customer payment *success projection* is missing in the backend; its published route is an intentional unsupported boundary.

Unless noted, responses use `{status:int,message:String,data:T?,error:Map?}`. Retrofit reads all four envelope fields; `isSuccess` is `status == 1`. Direct clients read status/data, plus message where stated. `Page<T>` reads `items,page,size,totalItems,totalPages,hasNext`; search clients only read `items`. Lists decode every row. Shape links below enumerate the actual fields read/sent, including nested DTOs and legacy optional probes. Optional probes with no backend counterpart do not make a valid canonical response fail; they remain null and have no authoritative replacement.

Common headers: JSON Content-Type; authenticated clients attach `Authorization: Bearer <accessToken>`. Only order creation adds an `Idempotency-Key`. No app call uses internal service credentials.

| # | Method + resolved path template | App call evidence | Query | Body fields/types | Response fields read | Verdict / resolution | Backend contract id / public edge id |
|---|---|---|---|---|---|---|---|
| 1 | `POST /api/firebase/register-token` | `lib/app/bootstrap/push/firebase_push_adapters.dart:79` | — | token:String | No envelope fields read (HTTP result only) | **OK**  | `notification-service:FirebaseController.registerFcmToken:POST:/api/firebase/register-token`; edge `firebase-service` |
| 2 | `POST /api/firebase/unregister-token` | `lib/app/bootstrap/push/firebase_push_adapters.dart:84` | — | token:String | No envelope fields read (HTTP result only) | **OK**  | `notification-service:FirebaseController.unregisterFcmToken:POST:/api/firebase/unregister-token`; edge `firebase-service` |
| 3 | `POST /api/auth/refresh-token` | `lib/core/network/dio/interceptors/auth_interceptor.dart:118` | — | refreshToken:String | status, message, data.{accessToken,refreshToken} | **OK**  | `auth-service:AuthController.refreshToken:POST:/api/auth/refresh-token`; edge `auth-service-public` |
| 4 | `POST /api/auth/login` | `lib/features/auth/data/datasources/auth_remote_datasource_impl.dart:20` | — | [Login](#shape-login) | BaseResponse<[AuthTokens](#shape-authtokens)> | **OK**  | `auth-service:AuthController.login:POST:/api/auth/login`; edge `auth-service-public` |
| 5 | `POST /api/auth/social-login` | `lib/features/auth/data/datasources/auth_remote_datasource_impl.dart:23` | — | [SocialLogin](#shape-sociallogin) | BaseResponse<[AuthTokens](#shape-authtokens)> | **OK**  | `auth-service:AuthController.socialLogin:POST:/api/auth/social-login`; edge `auth-service-public` |
| 6 | `POST /api/auth/register` | `lib/features/auth/data/datasources/auth_remote_datasource_impl.dart:28` | — | [Register](#shape-register) | BaseResponse<[Registration](#shape-registration)> | **MISMATCH → OK** Removed client-only name from wire body; fullName remains in user profile handoff. | `auth-service:AuthController.register:POST:/api/auth/register`; edge `auth-service-public` |
| 7 | `GET /api/auth/registrations/{handle}` | `lib/features/auth/data/datasources/auth_remote_datasource_impl.dart:33` | — | — | BaseResponse<[RegistrationStatus](#shape-registrationstatus)> | **OK**  | `auth-service:AuthController.registrationStatus:GET:/api/auth/registrations/{handle}`; edge `auth-service-registration-status` |
| 8 | `POST /api/users/registrations` | `lib/features/auth/data/datasources/auth_remote_datasource_impl.dart:38` | — | [UserRegistration](#shape-userregistration) | BaseResponse<[RegisteredUser](#shape-registereduser)> | **OK**  | `user-service:UserController.registerUser:POST:/api/users/registrations`; edge `user-service-registration` |
| 9 | `POST /api/auth/refresh-token` | `lib/features/auth/data/datasources/auth_remote_datasource_impl.dart:43` | — | refreshToken:String | BaseResponse<[RefreshTokens](#shape-refreshtokens)> | **OK**  | `auth-service:AuthController.refreshToken:POST:/api/auth/refresh-token`; edge `auth-service-public` |
| 10 | `POST /api/auth/logout` | `lib/features/auth/data/datasources/auth_remote_datasource_impl.dart:48` | — | refreshToken:String | BaseResponse<void> | **OK**  | `auth-service:AuthController.logout:POST:/api/auth/logout`; edge `auth-service-public` |
| 11 | `POST /api/auth/forgot-password` | `lib/features/auth/data/datasources/auth_remote_datasource_impl.dart:51` | — | email:String | BaseResponse<void> | **OK**  | `auth-service:AuthController.forgotPassword:POST:/api/auth/forgot-password`; edge `auth-service-public` |
| 12 | `POST /api/auth/reset-password` | `lib/features/auth/data/datasources/auth_remote_datasource_impl.dart:56` | — | token:String, newPassword:String | BaseResponse<void> | **OK**  | `auth-service:AuthController.resetPassword:POST:/api/auth/reset-password`; edge `auth-service-public` |
| 13 | `GET /api/promotions/capability` | `lib/features/cart/application/checkout_voucher.dart:215` | — | — | BaseResponse<[VoucherCapability](#shape-vouchercapability)> | **OK**  | `promotion-service:PromotionController.capability:GET:/api/promotions/capability`; edge `promotion-service-user-capability` |
| 14 | `GET /api/promotions/my-vouchers` | `lib/features/cart/application/checkout_voucher.dart:231` | — | — | BaseResponse<List<[Voucher](#shape-voucher)>> | **OK**  | `promotion-service:PromotionController.getMyVouchers:GET:/api/promotions/my-vouchers`; edge `promotion-service-user-vouchers` |
| 15 | `POST /api/promotions/collect/{code}` | `lib/features/cart/application/checkout_voucher.dart:256` | — | — | status only (data ignored) | **OK**  | `promotion-service:PromotionController.collectVoucher:POST:/api/promotions/collect/{code}`; edge `promotion-service-user-collect` |
| 16 | `GET /api/search/dishes` | `lib/features/catalog/di/catalog_search_providers.dart:41` | q:String, page:int, size:int | — | status, message, data.items:List<[CatalogDishSearch](#shape-catalogdishsearch)> | **OK**  | `search-service:SearchController.searchDishes:GET:/api/search/dishes`; edge `search-service-public` |
| 17 | `GET /api/search/restaurants` | `lib/features/catalog/di/catalog_search_providers.dart:62` | q:String, page:int, size:int | — | status, message, data.items:List<[CatalogRestaurantSearch](#shape-catalogrestaurantsearch)> | **OK**  | `search-service:SearchController.searchRestaurants:GET:/api/search/restaurants`; edge `search-service-public` |
| 18 | `GET /api/flashsales/public/campaigns` | `lib/features/flash_sale/data/datasources/flash_sale_remote_data_source_impl.dart:15` | — | — | BaseResponse<List<[FlashCampaign](#shape-flashcampaign)>> | **OK**  | `flashsale-service:PublicFlashSaleController.getActiveCampaigns:GET:/api/flashsales/public/campaigns`; edge `flashsale-public` |
| 19 | `GET /api/flashsales/public/campaigns/{campaignId}/items` | `lib/features/flash_sale/data/datasources/flash_sale_remote_data_source_impl.dart:27` | — | — | BaseResponse<List<[FlashItem](#shape-flashitem)>> | **OK**  | `flashsale-service:PublicFlashSaleController.getItems:GET:/api/flashsales/public/campaigns/{campaignId}/items`; edge `flashsale-public` |
| 20 | `GET /api/livestreams/{id}` | `lib/features/livestream/data/livestream_gateway.dart:15` | — | — | BaseResponse<[Livestream](#shape-livestream)> | **OK** Gateway route gated by app.livestream.client-api-enabled; existing errors preserved. | `livestream-service:LivestreamController.getLivestreamById:GET:/api/livestreams/{id}`; edge `livestream-viewer` |
| 21 | `GET /api/livestreams/active` | `lib/features/livestream/data/livestream_gateway.dart:34` | — | — | BaseResponse<List<[Livestream](#shape-livestream)>> | **OK** Gateway route gated by app.livestream.client-api-enabled; existing errors preserved. | `livestream-service:LivestreamController.getActiveLivestreams:GET:/api/livestreams/active`; edge `livestream-viewer` |
| 22 | `POST /api/livestreams/{id}/join` | `lib/features/livestream/data/livestream_gateway.dart:63` | — | — | BaseResponse<[Join](#shape-join)> | **OK** Gateway route gated by app.livestream.client-api-enabled; existing errors preserved. | `livestream-service:LivestreamController.joinLivestream:POST:/api/livestreams/{id}/join`; edge `livestream-viewer-join` |
| 23 | `POST /api/livestreams/{id}/token/renew` | `lib/features/livestream/data/livestream_gateway.dart:114` | — | — | BaseResponse<[Renew](#shape-renew)> | **OK** Gateway route gated by app.livestream.client-api-enabled; existing errors preserved. | `livestream-service:LivestreamTokenRenewalController.renew:POST:/api/livestreams/{id}/token/renew`; edge `livestream-token-renewal` |
| 24 | `GET /api/notifications/user/{userId}` | `lib/features/notification/data/datasources/notification_api_service.dart:14` | — | — | BaseResponse<List<[Notification](#shape-notification)>> | **OK**  | `notification-service:NotificationController.getUserNotifications:GET:/api/notifications/user/{userId}`; edge `notification-service-read` |
| 25 | `GET /api/notifications/unread` | `lib/features/notification/data/datasources/notification_api_service.dart:20` | — | — | BaseResponse<List<[Notification](#shape-notification)>> | **OK**  | `notification-service:NotificationController.getUnreadNotifications:GET:/api/notifications/unread`; edge `notification-service-read` |
| 26 | `GET /api/notifications/unread-count` | `lib/features/notification/data/datasources/notification_api_service.dart:24` | — | — | BaseResponse<int> | **OK**  | `notification-service:NotificationController.getUnreadCount:GET:/api/notifications/unread-count`; edge `notification-service-read` |
| 27 | `PUT /api/notifications/{id}/read` | `lib/features/notification/data/datasources/notification_api_service.dart:28` | — | — | BaseResponse<[Notification](#shape-notification)> | **OK**  | `notification-service:NotificationController.markAsRead:PUT:/api/notifications/{id}/read`; edge `notification-service-update` |
| 28 | `PUT /api/notifications/mark-all-read` | `lib/features/notification/data/datasources/notification_api_service.dart:32` | — | — | BaseResponse<int> | **OK**  | `notification-service:NotificationController.markAllAsRead:PUT:/api/notifications/mark-all-read`; edge `notification-service-update` |
| 29 | `GET /api/notifications/{id}` | `lib/features/notification/data/datasources/notification_api_service.dart:36` | — | — | BaseResponse<[Notification](#shape-notification)> | **OK**  | `notification-service:NotificationController.getNotificationById:GET:/api/notifications/{id}`; edge `notification-service-read` |
| 30 | `DELETE /api/notifications/{id}` | `lib/features/notification/data/datasources/notification_api_service.dart:42` | — | — | BaseResponse<void> | **OK**  | `notification-service:NotificationController.deleteNotification:DELETE:/api/notifications/{id}`; edge `notification-service-delete` |
| 31 | `GET /api/deliveries/order/{orderId}` | `lib/features/orders/data/datasources/delivery_tracking_remote_datasource_impl.dart:18` | — | — | BaseResponse<[Delivery](#shape-delivery)> | **OK**  | `delivery-service:DeliveryController.getDeliveryByOrderId:GET:/api/deliveries/order/{orderId}`; edge `delivery-service-read` |
| 32 | `GET /api/orders/my-orders` | `lib/features/orders/data/datasources/order_api_service.dart:17` | page:int, size:int | — | BaseResponse<Page<[Order](#shape-order)>> | **OK**  | `order-service:OrderController.getMyOrders:GET:/api/orders/my-orders`; edge `order-service-customer-self` |
| 33 | `GET /api/orders/{id}` | `lib/features/orders/data/datasources/order_api_service.dart:24` | — | — | BaseResponse<[Order](#shape-order)> | **OK**  | `order-service:OrderController.getOrderById:GET:/api/orders/{id}`; edge `order-service-read` |
| 34 | `POST /api/orders` | `lib/features/orders/data/datasources/order_api_service.dart:28` | — | [CreateOrder](#shape-createorder) | BaseResponse<[Order](#shape-order)> | **OK**  | `order-service:OrderController.createOrder:POST:/api/orders`; edge `order-service-create` |
| 35 | `POST /api/orders/checkout-preview` | `lib/features/orders/data/datasources/order_api_service.dart:42` | — | [PreviewRequest](#shape-previewrequest) | BaseResponse<[Preview](#shape-preview)> | **OK** Source confirms shippingFee/discountAmount/totalPrice/couponMessage/newPrice omitted by generated schema. | `order-service:OrderController.checkoutPreview:POST:/api/orders/checkout-preview`; edge `order-service-create` |
| 36 | `PUT /api/orders/{id}/cancel` | `lib/features/orders/data/datasources/order_api_service.dart:48` | — | reason?:String | BaseResponse<[Order](#shape-order)> | **OK**  | `order-service:OrderController.cancelOrder:PUT:/api/orders/{id}/cancel`; edge `order-service-cancel` |
| 37 | `GET /api/settlement/refunds/my` | `lib/features/orders/data/datasources/refund_api_service.dart:15` | limit:int | — | BaseResponse<List<[Refund](#shape-refund)>> | **OK**  | `settlement-service:RefundCustomerController.list:GET:/api/settlement/refunds/my`; edge `settlement-service-customer-refund-read` |
| 38 | `POST /api/restaurants/{restaurantId}/ratings` | `lib/features/orders/data/datasources/restaurant_rating_api_service.dart:13` | — | [Rating](#shape-rating) | BaseResponse<dynamic>; status/message read, data ignored | **OK**  | `restaurant-service:RestaurantRatingController.submitRating:POST:/api/restaurants/{restaurantId}/ratings`; edge `restaurant-rating-submit` |
| 39 | `GET /api/settlement/payments/ref/{paymentRef}` | `lib/features/payments/data/customer_payment_gateway.dart:16` | — | — | HTTP 409 BaseResponse<void> failure; no success fields read | **MISSING_IN_BACKEND** (customer success projection; controller route exists) Removed invented paymentRef/status success projection. Existing coordinator reports refreshFailed; feature disabled by default. Backend capability remains unavailable. | `settlement-service:CustomerPaymentController.getByReference:GET:/api/settlement/payments/ref/{paymentRef}`; edge `settlement-service-customer-payment-reference` |
| 40 | `GET /api/users` | `lib/features/profile/data/datasources/profile_remote_datasource_impl.dart:17` | — | — | BaseResponse<[Profile](#shape-profile)> | **MISMATCH → OK** createdAt/updatedAt now decode into existing Dart timestamp properties. | `user-service:UserController.getCurrentUser:GET:/api/users`; edge `user-service-current` |
| 41 | `PUT /api/users` | `lib/features/profile/data/datasources/profile_remote_datasource_impl.dart:20` | — | [ProfileUpdate](#shape-profileupdate) | BaseResponse<[Profile](#shape-profile)> | **MISMATCH → OK** createdAt/updatedAt now decode into existing Dart timestamp properties. | `user-service:UserController.updateCurrentUser:PUT:/api/users`; edge `user-service-current` |
| 42 | `GET /api/restaurants` | `lib/features/restaurants/data/datasources/restaurant_remote_datasource_impl.dart:20` | — | — | BaseResponse<List<[Restaurant](#shape-restaurant)>> | **MISMATCH → OK** Removed unbound optional filters/pagination; preserves existing unfiltered list response. | `restaurant-service:RestaurantController.getAll:GET:/api/restaurants`; edge `restaurant-catalog-public` |
| 43 | `GET /api/restaurants/{id}` | `lib/features/restaurants/data/datasources/restaurant_remote_datasource_impl.dart:25` | — | — | BaseResponse<[Restaurant](#shape-restaurant)> | **OK**  | `restaurant-service:RestaurantController.getById:GET:/api/restaurants/{id}`; edge `restaurant-catalog-public` |
| 44 | `GET /api/menu-items/restaurant/{restaurantId}/available` | `lib/features/restaurants/data/datasources/restaurant_remote_datasource_impl.dart:28` | — | — | BaseResponse<List<[MenuItem](#shape-menuitem)>> | **OK**  | `restaurant-service:MenuItemController.getAvailableItems:GET:/api/menu-items/restaurant/{restaurantId}/available`; edge `restaurant-menu-public` |
| 45 | `GET /api/restaurants/search` | `lib/features/restaurants/data/datasources/restaurant_remote_datasource_impl.dart:33` | keyword:String | — | BaseResponse<List<[Restaurant](#shape-restaurant)>> | **MISMATCH → OK** Removed unbound optional filters/pagination; preserves existing unfiltered list response. | `restaurant-service:RestaurantController.search:GET:/api/restaurants/search`; edge `restaurant-catalog-public` |
| 46 | `GET /api/search/restaurants` | `lib/features/search/data/datasources/search_remote_datasource.dart:51` | q:String, page:int, size:int | — | status, message, data.items:List<[RestaurantSearch](#shape-restaurantsearch)> | **OK**  | `search-service:SearchController.searchRestaurants:GET:/api/search/restaurants`; edge `search-service-public` |
| 47 | `GET /api/search/dishes` | `lib/features/search/data/datasources/search_remote_datasource.dart:74` | q:String, page:int, size:int | — | status, message, data.items:List<[DishSearch](#shape-dishsearch)> | **OK**  | `search-service:SearchController.searchDishes:GET:/api/search/dishes`; edge `search-service-public` |
| 48 | `POST /api/auth/firebase/chat-token` | `lib/features/support/data/firebase_support_repository.dart:196` | — | — | data.{token,principalId}; SDK custom-token sign-in checks UID | **OK**  | `auth-service:AuthController.firebaseChatToken:POST:/api/auth/firebase/chat-token`; edge `auth-service-firebase-chat-token` |
| 49 | `GET /api/addresses/users/{userId}/addresses` | `lib/features/user_address/data/datasources/user_address_api_service.dart:14` | — | — | BaseResponse<List<[Address](#shape-address)>> | **OK**  | `user-service:UserAddressController.getUserAddresses:GET:/api/addresses/users/{userId}/addresses`; edge `user-address-service-read` |
| 50 | `GET /api/addresses/{id}` | `lib/features/user_address/data/datasources/user_address_api_service.dart:20` | — | — | BaseResponse<[Address](#shape-address)> | **OK**  | `user-service:UserAddressController.getAddress:GET:/api/addresses/{id}`; edge `user-address-service-read` |
| 51 | `POST /api/addresses/users/{userId}/addresses` | `lib/features/user_address/data/datasources/user_address_api_service.dart:26` | — | [AddressRequest](#shape-addressrequest) | BaseResponse<[Address](#shape-address)> | **OK**  | `user-service:UserAddressController.createAddress:POST:/api/addresses/users/{userId}/addresses`; edge `user-address-service-create` |
| 52 | `PUT /api/addresses/{id}` | `lib/features/user_address/data/datasources/user_address_api_service.dart:33` | — | [AddressRequest](#shape-addressrequest) | BaseResponse<[Address](#shape-address)> | **OK**  | `user-service:UserAddressController.updateAddress:PUT:/api/addresses/{id}`; edge `user-address-service-update` |
| 53 | `DELETE /api/addresses/{id}` | `lib/features/user_address/data/datasources/user_address_api_service.dart:40` | — | — | BaseResponse<void> | **OK**  | `user-service:UserAddressController.deleteAddress:DELETE:/api/addresses/{id}`; edge `user-address-service-delete` |
| 54 | `PATCH /api/addresses/{id}/default` | `lib/features/user_address/data/datasources/user_address_api_service.dart:44` | — | — | BaseResponse<[Address](#shape-address)> | **OK**  | `user-service:UserAddressController.setDefault:PATCH:/api/addresses/{id}/default`; edge `user-address-service-default` |

## Shapes and parser evidence

<a id="shape-login"></a>

- **Login** — email:String, password:String, deviceId:String, deviceName?:String, deviceType?:String (DeviceType enum), ipAddress?:String. App: `lib/features/auth/data/dtos/login_request_dto.dart:1` (generated `.g.dart` implements Freezed JSON mappings where present).

<a id="shape-sociallogin"></a>

- **SocialLogin** — provider:String, token:String, role?:String, deviceId:String, deviceName?:String, deviceType?:String, ipAddress?:String. App: `lib/features/auth/data/dtos/social_login_request_dto.dart:1` (generated `.g.dart` implements Freezed JSON mappings where present).

<a id="shape-register"></a>

- **Register** — email:String, password:String, role:String; client-only name is excluded. App: `lib/features/auth/data/dtos/register_request_dto.dart:1` (generated `.g.dart` implements Freezed JSON mappings where present).

<a id="shape-authtokens"></a>

- **AuthTokens** — accessToken, refreshToken; legacy optional user.{id,email,name,createdAt} is tolerated but not emitted by AuthResponse; only tokens are consumed. App: `lib/features/auth/data/dtos/auth_response_dto.dart:1` (generated `.g.dart` implements Freezed JSON mappings where present).

<a id="shape-refreshtokens"></a>

- **RefreshTokens** — accessToken, refreshToken. App: `lib/features/auth/data/dtos/refresh_token_response_dto.dart:1` (generated `.g.dart` implements Freezed JSON mappings where present).

<a id="shape-registration"></a>

- **Registration** — authId, principalId, email, role, provisioningToken, registrationHandle, expiresAt, lifecycleStatus. App: `lib/features/auth/data/dtos/register_request_dto.dart:1` (generated `.g.dart` implements Freezed JSON mappings where present).

<a id="shape-registrationstatus"></a>

- **RegistrationStatus** — principalId, status, nextAction, profileLinked, expiresAt. App: `lib/features/auth/data/dtos/register_request_dto.dart:1` (generated `.g.dart` implements Freezed JSON mappings where present).

<a id="shape-userregistration"></a>

- **UserRegistration** — provisioningToken:String, fullName?:String. App: `lib/features/auth/data/dtos/register_request_dto.dart:1` (generated `.g.dart` implements Freezed JSON mappings where present).

<a id="shape-registereduser"></a>

- **RegisteredUser** — id, authId, email, role, fullName. App: `lib/features/auth/data/dtos/register_request_dto.dart:1` (generated `.g.dart` implements Freezed JSON mappings where present).

<a id="shape-profile"></a>

- **Profile** — id, authId, email, role, fullName, phone, dob, avatarUrl, address, createdAt, updatedAt (last two map to Dart createdAtString/updatedAtString). App: `lib/features/profile/data/dtos/user_profile_dto.dart:1` (generated `.g.dart` implements Freezed JSON mappings where present).

<a id="shape-profileupdate"></a>

- **ProfileUpdate** — fullName?:String, phone?:String, dob?:String (ISO local date), address?:String. App: `lib/features/profile/data/dtos/update_profile_request_dto.dart:1` (generated `.g.dart` implements Freezed JSON mappings where present).

<a id="shape-restaurant"></a>

- **Restaurant** — id, name, description, address, phone, image, openingHour, closingHour, latitude, longitude (coordinates map to addressLat/addressLng; optional legacy aliases tolerated). App: `lib/features/restaurants/data/dtos/restaurant_dto.dart:1` (generated `.g.dart` implements Freezed JSON mappings where present).

<a id="shape-menuitem"></a>

- **MenuItem** — id, restaurantId, name, description (null maps to empty), price, image, status. App: `lib/features/restaurants/data/dtos/menu_item_dto.dart:1` (generated `.g.dart` implements Freezed JSON mappings where present).

<a id="shape-restaurantsearch"></a>

- **RestaurantSearch** — id, name, description, cuisine, rating, imageUrl. App: `lib/features/search/data/models/search_result_model.dart:1` (generated `.g.dart` implements Freezed JSON mappings where present).

<a id="shape-dishsearch"></a>

- **DishSearch** — id, name, description, price, restaurantId, imageUrl. App: `lib/features/search/data/models/search_result_model.dart:1` (generated `.g.dart` implements Freezed JSON mappings where present).

<a id="shape-catalogrestaurantsearch"></a>

- **CatalogRestaurantSearch** — id, name, description, cuisine, rating, imageUrl; optional image, distanceKm/distance, deliveryTimeMinutes/deliveryTime legacy probes have no backend values and remain null. App: `lib/features/catalog/di/catalog_search_providers.dart:1` (generated `.g.dart` implements Freezed JSON mappings where present).

<a id="shape-catalogdishsearch"></a>

- **CatalogDishSearch** — id, name, description, price, restaurantId, imageUrl (optional legacy image tolerated). App: `lib/features/catalog/di/catalog_search_providers.dart:1` (generated `.g.dart` implements Freezed JSON mappings where present).

<a id="shape-addressrequest"></a>

- **AddressRequest** — label:String, recipientName:String, phoneNumber:String, addressLine:String, ward:String, district:String, city:String, postalCode?:String, latitude?:double, longitude?:double, isDefault?:bool. App: `lib/features/user_address/data/dtos/user_address_request_dto.dart:1` (generated `.g.dart` implements Freezed JSON mappings where present).

<a id="shape-address"></a>

- **Address** — id, userId, label, recipientName, phoneNumber, addressLine, ward, district, city, postalCode, latitude, longitude, isDefault, createdAt, updatedAt. App: `lib/features/user_address/data/dtos/user_address_response_dto.dart:1` (generated `.g.dart` implements Freezed JSON mappings where present).

<a id="shape-notification"></a>

- **Notification** — id, userId, title, message, type, priority, status, isRead, relatedEntityId, relatedEntityType, data (JSON string), sentAt, readAt, createdAt, updatedAt. App: `lib/features/notification/data/dtos/notification_dto.dart:1` (generated `.g.dart` implements Freezed JSON mappings where present).

<a id="shape-createorder"></a>

- **CreateOrder** — quoteId?:String(UUID), livestreamId?:String(UUID), restaurantId:int, deliveryAddress:String, deliveryLat:double, deliveryLng:double, customerName:String, customerPhone:String, paymentMethod:String, notes?:String, voucherIds?:List<int>, selectionMode?:String, items:List<{menuItemId:int,quantity:int,notes?:String,flashSaleItemId?:int}>; idempotencyKey excluded from body. App: `lib/features/orders/data/dtos/create_order_request_dto.dart:1` (generated `.g.dart` implements Freezed JSON mappings where present).

<a id="shape-order"></a>

- **Order** — id, status, customerName, customerPhone, deliveryAddress, paymentMethod, subtotalPrice, discountAmount, shippingFee, totalPrice (maps to totalAmount), notes, items.{id,menuItemId,menuItemName,quantity,price,notes}, createdAt, updatedAt, shipperId, restaurantId, restaurantName, restaurantAddress, restaurantPhone, restaurantLat, restaurantLng, pickupLat, pickupLng; optional estimatedDeliveryTime/cancelReason are not emitted by OrderResponse and remain null. App: `lib/features/orders/data/dtos/order_dto.dart:1` (generated `.g.dart` implements Freezed JSON mappings where present).

<a id="shape-previewrequest"></a>

- **PreviewRequest** — livestreamId?:String(UUID), restaurantId:int, deliveryLat:double, deliveryLng:double, couponCode?:String, voucherId?:int, selectedVoucherIds?:List<int>, selectionMode?:String, items:List<{menuItemId:int,quantity:int,flashSaleItemId?:int}>. App: `lib/features/orders/data/dtos/checkout_preview_dto.dart:1` (generated `.g.dart` implements Freezed JSON mappings where present).

<a id="shape-preview"></a>

- **Preview** — quoteId, expiresAt, restaurantId, restaurantName, items.{menuItemId,menuItemName,imageUrl,unitPrice,quantity,lineTotal}, subtotal, shippingFee, discountAmount, totalPrice, couponCode, couponMessage, voucherId, selectedVoucherIds, selectionMode, itemDiscount, shippingDiscount, customerShippingFee, grossShippingFee, platformSubsidy, shopDiscount, appliedVouchers.{voucherId,code,layer,fundingSource,discountBase,discountAmount}, priceChanges.{menuItemId,menuItemName,oldPrice,newPrice}, unavailableItemIds. App: `lib/features/orders/data/dtos/checkout_preview_dto.dart:1` (generated `.g.dart` implements Freezed JSON mappings where present).

<a id="shape-delivery"></a>

- **Delivery** — id, orderId, shipperId, status, pickupLat, pickupLng, deliveryLat, deliveryLng, shipperCurrentLat, shipperCurrentLng, pickupAddress, deliveryAddress, estimatedDeliveryTime (maps to estimatedTime), assignedAt, pickedUpAt, deliveredAt, notes, createdAt, updatedAt. App: `lib/features/orders/data/dtos/current_delivery_dto.dart:1` (generated `.g.dart` implements Freezed JSON mappings where present).

<a id="shape-refund"></a>

- **Refund** — refundId, orderId, paymentMethod, trigger, status, currency, refundAmount, createdAt, updatedAt, processedAt. App: `lib/features/orders/data/dtos/refund_case_dto.dart:1` (generated `.g.dart` implements Freezed JSON mappings where present).

<a id="shape-rating"></a>

- **Rating** — orderId:int, rating:int, comment?:String. App: `lib/features/orders/data/dtos/restaurant_rating_request_dto.dart:1` (generated `.g.dart` implements Freezed JSON mappings where present).

<a id="shape-flashcampaign"></a>

- **FlashCampaign** — id, name, isRecurring, startTime, endTime, status. App: `lib/features/flash_sale/data/models/flash_sale_campaign_model.dart:1` (generated `.g.dart` implements Freezed JSON mappings where present).

<a id="shape-flashitem"></a>

- **FlashItem** — id, campaignId, restaurantId, menuItemId, originalPrice, flashSalePrice, stockQuantity, soldQuantity, status; optional menuItemName/imageUrl probes are not emitted and stay null (catalog hydrates the corresponding menu item separately). App: `lib/features/flash_sale/data/models/flash_sale_item_model.dart:1` (generated `.g.dart` implements Freezed JSON mappings where present).

<a id="shape-vouchercapability"></a>

- **VoucherCapability** — enabled, maxVouchers, layers, selectionModes, conflictsWithFlashSale. App: `lib/features/cart/application/checkout_voucher.dart:1` (generated `.g.dart` implements Freezed JSON mappings where present).

<a id="shape-voucher"></a>

- **Voucher** — id, code, name, rewardType, discountValue, creatorType, scopeType, scopeRefId, minOrderValue, maxDiscountValue, layerCode (legacy layer fallback), fundingSource, startTime, endTime, active, approvalStatus, totalQuantity, usedQuantity, usageLimitPerUser. App: `lib/features/cart/application/checkout_voucher.dart:1` (generated `.g.dart` implements Freezed JSON mappings where present).

<a id="shape-livestream"></a>

- **Livestream** — id, sellerId, restaurantId, title, description, status, streamProvider, roomId, channelName, startedAt, endedAt, viewCount, pinnedProducts.{id,livestreamId,productId,productName,productImage,restaurantId,restaurantName,priceAtLive,isPinned,pinnedAt}. App: `lib/features/livestream/domain/entities/livestream.dart:1` (generated `.g.dart` implements Freezed JSON mappings where present).

<a id="shape-join"></a>

- **Join** — livestreamId, channelName, token, uid, tokenExpiresAt, title, restaurantId. App: `lib/features/livestream/data/livestream_gateway.dart:1` (generated `.g.dart` implements Freezed JSON mappings where present).

<a id="shape-renew"></a>

- **Renew** — livestreamId, channelName, token, uid, role, tokenExpiresAt. App: `lib/features/livestream/data/livestream_gateway.dart:1` (generated `.g.dart` implements Freezed JSON mappings where present).

## Source-authority checks and limitations

- `backend_delivery/order/infrastructure/src/main/java/com/delivery/order_service/dto/response/CheckoutPreviewResponse.java` declares shippingFee, discountAmount, totalPrice, couponMessage and nested newPrice even though the generated schema omits these inline-commented declarations. The app is compatible with source; those fields were retained.
- `backend_delivery/user/infrastructure/src/main/java/com/delivery/user_service/dto/UserResponse.java` confirms createdAt/updatedAt, not createdAtString/updatedAtString.
- `backend_delivery/settlement/infrastructure/src/main/java/com/delivery/settlement_service/controller/CustomerPaymentController.java` getByReference returns BaseResponse<Void>, with 409 CUSTOMER_PAYMENT_OWNERSHIP_UNSUPPORTED (or 403/400 access/validation failures). No owned customer success DTO exists. The client retains its existing refreshFailed UI path and rejects fabricated success projections. Backend implementation of that capability is follow-up work.
- RestaurantController.getAll has no query bindings; search binds keyword only. The old latitude/longitude/category/searchQuery/page/limit filters were ignored by the backend. Removing them preserves actual UI list behavior; implementing those capabilities would require backend/product work.
- Login and social-login backend deviceId is required. Production auth repository forwards device identity from its use-case parameters; DTO nullable declarations retain existing call-site compatibility and do not change valid wire values.

## External HTTP and SDK boundaries

These are outside the delivery Gateway, so the delivery backend verdict is **MISSING_IN_BACKEND (external service, intentional)**. They are not asserted against the delivery route snapshots.

| Method/path | Query/body | Response read | App evidence |
|---|---|---|---|
| GET `https://api.mapbox.com/directions/v5/mapbox/driving/{originLng},{originLat};{destLng},{destLat}` | geometries:String (default geojson), access_token:String | Raw response Map passed to tracking; routes[0].geometry.coordinates read by tracking coordinator | `lib/features/orders/data/services/mapbox_map_service.dart:55` |
| POST `https://api.cloudinary.com/v1_1/djnfk8j8v/image/upload` | Multipart file, upload_preset=delivery, folder (default support_chat), optional public_id; SDK fields | CloudinaryResponse.secureUrl and returned SDK response | `lib/core/services/image_upload/cloudinary_image_upload_service.dart:26` |
| POST `https://api.cloudinary.com/v1_1/djnfk8j8v/video/upload` | Same upload fields; video resource type | CloudinaryResponse.secureUrl and returned SDK response | `lib/core/services/image_upload/cloudinary_image_upload_service.dart:52` |

Firebase Authentication, Firestore, FCM, Google Sign-In, Agora and Mapbox native SDK traffic is SDK-owned transport rather than app HTTP routes. Support Firestore reads/writes/streams use supportConversations/{id}/messages and are governed by Firebase rules; their HTTP URLs/envelopes are not assembled or parsed by this app. Media image/video widgets fetch their provided external URLs through framework/SDK loaders. Map links are navigation URLs, not app HTTP API calls. WebSocket tracking is `/ws/shipper-locations`, covered by existing socket tests and outside these HTTP manifests.

## Automated drift check

`test/core/contracts/backend_api_contract_test.dart` parses all nongenerated Dart under lib using analyzer syntax trees. It derives Retrofit verbs/paths and direct Dio routes, resolves ApiConstants and forwarding helpers, and normalizes path-variable names and Gateway regex constraints (including nested UUID quantifier braces). Unknown Dio path expressions or new request/fetch/download styles fail instead of being silently omitted. The only external direct Dio exception is Mapbox Directions; auth retry is explicitly accounted for above. No handwritten app route list is used. The test checks both controller presence and method-specific public exposure; it does not assert runtime feature-gate state or full DTO schema compatibility.

Refresh from the sibling checkout:

```sh
sh tool/refresh_backend_contracts.sh
```

For this worktree:

```sh
sh tool/refresh_backend_contracts.sh /Users/a/Documents/private/delivery/backend_delivery/docs/platform/system/api
```

Run `flutter test test/core/contracts/backend_api_contract_test.dart`. Use Flutter 3.32.8 at `/Users/a/fvm/versions/3.32.8/bin/flutter`.

## Validation

Using Flutter 3.32.8 / Dart 3.8.1:

- Red regressions failed for all three field differences (profile timestamps, registration name, catalog query fields); the payment regression rejected the old fabricated success handling.
- `flutter test --no-pub --no-test-assets test/core/contracts/backend_api_contract_test.dart test/features/payments/data/customer_payment_gateway_test.dart test/features/profile/data/datasources/profile_api_service_test.dart test/features/auth/data/datasources/auth_api_service_contract_test.dart test/features/restaurants/data/datasources/restaurant_api_service_contract_test.dart --reporter expanded`: **18 passed**, exit 0. Includes every changed parser/serializer and the 54-call route check.
- `sh tool/refresh_backend_contracts.sh /Users/a/Documents/private/delivery/backend_delivery/docs/platform/system/api`: exit 0; both snapshots remain byte-identical to authority.
- Required `flutter test --coverage`: **blocked before tests**, exit 1: `No file or variants found for asset: .env.` The checkout lacks the ignored local fixture. README documents `cp .env.example .env`, but `.env` is outside the assigned edit scope; parent authorization/setup is needed.
- Supplementary `flutter test --coverage --no-test-assets --reporter expanded`: **450 passed, 33 failed**, exit 1. All 33 failures report missing `shaders/ink_sparkle.frag` or font assets because the test bundle was not built. Coverage was emitted, but this is not a substitute for a green full run with assets.
- `flutter analyze`: **exit 1, 3 issues**: missing `.env` asset warning plus existing cameraOptions deprecation infos in `lib/features/home/presentation/widgets/map_widget.dart:31` and `lib/features/orders/presentation/services/tracking_map_platform.dart:29`. No API-contract source/test analysis errors remain.

No git commands, backend edits or UI changes were made. Whole data-layer coverage expansion is intentionally deferred per the bounded assignment. Completion requires the local `.env` asset and re-running the required checks; existing native-map deprecations also need parent disposition.

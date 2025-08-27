// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'network_providers.dart';
// import 'authenticated_network_providers.dart';

// /// Example of how other features can use the shared Dio instances

// // Example: User Profile API Service
// class UserProfileApiService {
//   final Dio _dio;

//   UserProfileApiService(this._dio);

//   Future<Map<String, dynamic>> getUserProfile(String userId) async {
//     final response = await _dio.get('/users/$userId');
//     return response.data;
//   }

//   Future<Map<String, dynamic>> updateUserProfile(String userId, Map<String, dynamic> data) async {
//     final response = await _dio.put('/users/$userId', data: data);
//     return response.data;
//   }
// }

// // Provider for User Profile API Service (uses authenticated Dio)
// final userProfileApiServiceProvider = Provider<UserProfileApiService>((ref) {
//   final dio = ref.watch(authenticatedDioProvider); // Gets auth-aware Dio automatically
//   return UserProfileApiService(dio);
// });

// // Example: Public API Service (doesn't need authentication)
// class PublicApiService {
//   final Dio _dio;

//   PublicApiService(this._dio);

//   Future<List<dynamic>> getPublicData() async {
//     final response = await _dio.get('/public/data');
//     return response.data;
//   }

//   Future<Map<String, dynamic>> getAppConfig() async {
//     final response = await _dio.get('/public/config');
//     return response.data;
//   }
// }

// // Provider for Public API Service (uses basic Dio)
// final publicApiServiceProvider = Provider<PublicApiService>((ref) {
//   final dio = ref.watch(dioProvider); // Uses basic Dio without auth
//   return PublicApiService(dio);
// });

// // Example: Orders API Service (needs authentication)
// class OrdersApiService {
//   final Dio _dio;

//   OrdersApiService(this._dio);

//   Future<List<dynamic>> getUserOrders() async {
//     final response = await _dio.get('/orders');
//     return response.data;
//   }

//   Future<Map<String, dynamic>> createOrder(Map<String, dynamic> orderData) async {
//     final response = await _dio.post('/orders', data: orderData);
//     return response.data;
//   }

//   Future<Map<String, dynamic>> getOrderDetails(String orderId) async {
//     final response = await _dio.get('/orders/$orderId');
//     return response.data;
//   }
// }

// // Provider for Orders API Service (uses authenticated Dio)
// final ordersApiServiceProvider = Provider<OrdersApiService>((ref) {
//   final dio = ref.watch(authenticatedDioProvider); // Gets auth-aware Dio automatically
//   return OrdersApiService(dio);
// });

// /// Example of using these services in a widget
// /// 
// /// ```dart
// /// class UserProfileWidget extends ConsumerWidget {
// ///   @override
// ///   Widget build(BuildContext context, WidgetRef ref) {
// ///     final userProfileService = ref.watch(userProfileApiServiceProvider);
// ///     final ordersService = ref.watch(ordersApiServiceProvider);
// ///     
// ///     return FutureBuilder(
// ///       future: Future.wait([
// ///         userProfileService.getUserProfile('123'),
// ///         ordersService.getUserOrders(),
// ///       ]),
// ///       builder: (context, snapshot) {
// ///         if (snapshot.hasData) {
// ///           final profile = snapshot.data![0];
// ///           final orders = snapshot.data![1];
// ///           return Column(
// ///             children: [
// ///               Text('User: ${profile['name']}'),
// ///               Text('Orders: ${orders.length}'),
// ///             ],
// ///           );
// ///         }
// ///         return CircularProgressIndicator();
// ///       },
// ///     );
// ///   }
// /// }
// /// ```

// /// Benefits of this architecture:
// /// 
// /// 1. **Single Dio Instance**: All features share the same HTTP client configuration
// /// 2. **Automatic Authentication**: Services that need auth automatically get tokens
// /// 3. **No Circular Dependencies**: Auth module overrides the provider, other features just consume
// /// 4. **Easy Testing**: Mock the dio provider to test all services
// /// 5. **Consistent Configuration**: All HTTP requests use the same timeouts, base URL, etc.
// /// 6. **Automatic Token Refresh**: When tokens expire, all authenticated requests benefit from refresh
// /// 
// /// Testing example:
// /// 
// /// ```dart
// /// void main() {
// ///   testWidgets('User profile loads correctly', (tester) async {
// ///     final mockDio = MockDio();
// ///     when(mockDio.get('/users/123')).thenAnswer((_) async => Response(
// ///       data: {'name': 'Test User'},
// ///       statusCode: 200,
// ///       requestOptions: RequestOptions(path: '/users/123'),
// ///     ));
// ///     
// ///     await tester.pumpWidget(
// ///       ProviderScope(
// ///         overrides: [
// ///           authenticatedDioProvider.overrideWith((ref) => mockDio),
// ///         ],
// ///         child: UserProfileWidget(),
// ///       ),
// ///     );
// ///     
// ///     expect(find.text('User: Test User'), findsOneWidget);
// ///   });
// /// }
// /// ```

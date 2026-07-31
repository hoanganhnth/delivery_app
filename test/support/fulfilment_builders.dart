import 'package:delivery_app/features/cart/domain/entities/cart_entity.dart';
import 'package:delivery_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:delivery_app/features/orders/data/dtos/create_order_request_dto.dart';
import 'package:delivery_app/features/orders/domain/entities/order_entity.dart';
import 'package:delivery_app/features/orders/domain/entities/order_item_entity.dart';
import 'package:delivery_app/features/orders/domain/entities/delivery_tracking_entity.dart';
import 'package:delivery_app/features/orders/domain/entities/delivery_status.dart';
import 'package:delivery_app/features/restaurants/domain/entities/menu_item_entity.dart';
import 'package:delivery_app/features/restaurants/domain/entities/restaurant_entity.dart';
import 'package:delivery_app/features/user_address/domain/entities/user_address_entity.dart';
import 'package:delivery_app/features/profile/domain/entities/user_entity.dart';
import 'package:delivery_app/features/notification/domain/entities/notification_entity.dart';

RestaurantEntity buildRestaurant({num id = 201, String name = 'Bếp test'}) {
  return RestaurantEntity(
    id: id,
    name: name,
    description: 'Canonical restaurant fixture',
    address: '1 Đường Test, TP.HCM',
    phone: '0900000001',
    image: 'https://images.test/restaurant.jpg',
    rating: 4.5,
    reviewCount: 10,
    deliveryFee: 15000,
    deliveryTime: 30,
    isOpen: true,
    addressLat: 10.7769,
    addressLng: 106.7009,
  );
}

MenuItemEntity buildMenuItem({
  num id = 301,
  num restaurantId = 201,
  String name = 'Cơm test',
  double price = 50000,
  MenuItemStatus status = MenuItemStatus.available,
}) {
  return MenuItemEntity(
    id: id,
    restaurantId: restaurantId,
    name: name,
    description: 'Canonical menu fixture',
    price: price,
    image: 'https://images.test/menu.jpg',
    status: status,
  );
}

CartItemEntity buildCartItem({
  num menuItemId = 301,
  num restaurantId = 201,
  String name = 'Cơm test',
  String restaurantName = 'Bếp test',
  double price = 50000,
  int quantity = 1,
  String? notes,
  int? flashSaleItemId,
}) {
  return CartItemEntity(
    menuItemId: menuItemId,
    menuItemName: name,
    price: price,
    quantity: quantity,
    restaurantId: restaurantId,
    restaurantName: restaurantName,
    notes: notes,
    flashSaleItemId: flashSaleItemId,
  );
}

CartEntity buildCart({List<CartItemEntity>? items}) {
  final resolvedItems = items ?? [buildCartItem()];
  return CartEntity(
    items: resolvedItems,
    currentRestaurantId: resolvedItems.isEmpty
        ? null
        : resolvedItems.first.restaurantId,
    currentRestaurantName: resolvedItems.isEmpty
        ? null
        : resolvedItems.first.restaurantName,
  );
}

UserAddressEntity buildAddress({
  int id = 401,
  String label = 'Nhà',
  bool isDefault = true,
}) {
  return UserAddressEntity(
    id: id,
    userId: 501,
    label: label,
    recipientName: 'Customer Test',
    phoneNumber: '0900000002',
    addressLine: '2 Đường Khách',
    ward: 'Phường Test',
    district: 'Quận 1',
    city: 'TP.HCM',
    latitude: 10.78,
    longitude: 106.71,
    isDefault: isDefault,
  );
}

OrderEntity buildOrder({
  int id = 601,
  OrderStatus status = OrderStatus.pending,
  String rawStatus = 'PENDING',
}) {
  return OrderEntity(
    id: id,
    status: status,
    rawBackendStatus: rawStatus,
    customerName: 'Customer Test',
    customerPhone: '0900000002',
    deliveryAddress: '2 Đường Khách, TP.HCM',
    paymentMethod: PaymentMethod.cod,
    subtotalPrice: 50000,
    discountAmount: 0,
    shippingFee: 15000,
    totalAmount: 65000,
    items: const [
      OrderItemEntity(
        id: 701,
        menuItemId: 301,
        menuItemName: 'Cơm test',
        quantity: 1,
        price: 50000,
      ),
    ],
    restaurantId: 201,
    restaurantName: 'Bếp test',
  );
}

DeliveryTrackingEntity buildDeliveryTracking({
  int id = 801,
  int orderId = 601,
  int? shipperId = 701,
  DeliveryStatus status = DeliveryStatus.assigned,
  double? shipperCurrentLat = 10.77,
  double? shipperCurrentLng = 106.70,
}) {
  return DeliveryTrackingEntity(
    id: id,
    orderId: orderId,
    shipperId: shipperId,
    status: status,
    pickupAddress: '1 Đường Test, TP.HCM',
    pickupLat: 10.7769,
    pickupLng: 106.7009,
    deliveryAddress: '2 Đường Khách, TP.HCM',
    deliveryLat: 10.78,
    deliveryLng: 106.71,
    shipperCurrentLat: shipperCurrentLat,
    shipperCurrentLng: shipperCurrentLng,
  );
}

CreateOrderRequestDto buildCreateOrderRequest() {
  return const CreateOrderRequestDto(
    restaurantId: 201,
    deliveryAddress: '2 Đường Khách, TP.HCM',
    deliveryLat: 10.78,
    deliveryLng: 106.71,
    customerName: 'Customer Test',
    customerPhone: '0900000002',
    paymentMethod: 'COD',
    items: [OrderItemRequest(menuItemId: 301, quantity: 1)],
  );
}

UserEntity buildProfile({int authId = 501, String fullName = 'Customer Test'}) {
  return UserEntity(
    id: 601,
    authId: authId,
    email: 'customer@test.dev',
    role: 'USER',
    fullName: fullName,
    phone: '0900000002',
    address: '2 Đường Khách, TP.HCM',
  );
}

NotificationEntity buildNotification({
  int id = 901,
  String title = 'Đơn mới',
  bool isRead = false,
}) {
  return NotificationEntity(
    id: id,
    userId: 501,
    title: title,
    message: 'Bạn có một cập nhật giao hàng',
    type: 'DELIVERY',
    priority: 'HIGH',
    status: 'SENT',
    isRead: isRead,
    relatedEntityId: 601,
    relatedEntityType: 'ORDER',
    createdAt: DateTime.utc(2026, 7, 29, 8),
  );
}

import '../../domain/entities/order_entity.dart';
import '../../domain/entities/order_item_entity.dart';

/// Mock service cung cấp dữ liệu giả cho Orders khi develop và test
class MockOrderService {
  /// Instance singleton
  static final MockOrderService _instance = MockOrderService._internal();
  factory MockOrderService() => _instance;
  MockOrderService._internal();

  /// Lấy danh sách orders giả
  List<OrderEntity> getMockOrders() {
    return [
      // Order 1: Pending
      const OrderEntity(
        id: 1,
        status: OrderStatus.pending,
        customerName: 'Nguyễn Văn A',
        customerPhone: '0901234567',
        deliveryAddress: '123 Nguyễn Huệ, Quận 1, TP.HCM',
        paymentMethod: PaymentMethod.cash,
        totalAmount: 125000.0,
        items: [
          OrderItemEntity(
            id: 1,
            menuItemId: 101,
            menuItemName: 'Cơm Tấm Sướn Nướng',
            price: 65000.0,
            quantity: 1,
          ),
          OrderItemEntity(
            id: 2,
            menuItemId: 102,
            menuItemName: 'Nước Ngọt Coca Cola',
            price: 15000.0,
            quantity: 2,
          ),
          OrderItemEntity(
            id: 3,
            menuItemId: 103,
            menuItemName: 'Canh Chua Cá Lóc',
            price: 45000.0,
            quantity: 1,
          ),
        ],
        notes: 'Giao hàng trước 6h chiều',
      ),

      // Order 2: Confirmed
      const OrderEntity(
        id: 2,
        status: OrderStatus.confirmed,
        customerName: 'Trần Thị B',
        customerPhone: '0912345678',
        deliveryAddress: '789 Pasteur, Quận 3, TP.HCM',
        paymentMethod: PaymentMethod.wallet,
        totalAmount: 89000.0,
        items: [
          OrderItemEntity(
            id: 4,
            menuItemId: 201,
            menuItemName: 'Phở Bò Tái',
            price: 75000.0,
            quantity: 1,
          ),
          OrderItemEntity(
            id: 5,
            menuItemId: 202,
            menuItemName: 'Trà Đá',
            price: 5000.0,
            quantity: 1,
          ),
          OrderItemEntity(
            id: 6,
            menuItemId: 203,
            menuItemName: 'Bánh Mì Pate',
            price: 14000.0,
            quantity: 1,
          ),
        ],
        notes: '',
      ),

      // Order 3: Preparing
      const OrderEntity(
        id: 3,
        status: OrderStatus.preparing,
        customerName: 'Phạm Minh D',
        customerPhone: '0934567890',
        deliveryAddress: '147 Nguyễn Thị Minh Khai, Quận 1, TP.HCM',
        paymentMethod: PaymentMethod.card,
        totalAmount: 156000.0,
        items: [
          OrderItemEntity(
            id: 7,
            menuItemId: 301,
            menuItemName: 'Set BBQ Combo',
            price: 120000.0,
            quantity: 1,
          ),
          OrderItemEntity(
            id: 8,
            menuItemId: 302,
            menuItemName: 'Bia Saigon',
            price: 18000.0,
            quantity: 2,
          ),
        ],
        notes: 'Không cần gọi chuông, nhắn tin',
      ),

      // Order 4: Delivering
      const OrderEntity(
        id: 4,
        status: OrderStatus.delivering,
        customerName: 'Võ Thị F',
        customerPhone: '0956789012',
        deliveryAddress: '369 Điện Biên Phủ, Quận 3, TP.HCM',
        paymentMethod: PaymentMethod.wallet,
        totalAmount: 234000.0,
        items: [
          OrderItemEntity(
            id: 9,
            menuItemId: 401,
            menuItemName: 'Sushi Set A',
            price: 180000.0,
            quantity: 1,
          ),
          OrderItemEntity(
            id: 10,
            menuItemId: 402,
            menuItemName: 'Miso Soup',
            price: 25000.0,
            quantity: 1,
          ),
          OrderItemEntity(
            id: 11,
            menuItemId: 403,
            menuItemName: 'Green Tea',
            price: 29000.0,
            quantity: 1,
          ),
        ],
        notes: 'Tầng 5, thang máy bên trái',
      ),

      // Order 5: Delivered
      const OrderEntity(
        id: 5,
        status: OrderStatus.delivered,
        customerName: 'Đặng Quang H',
        customerPhone: '0978901234',
        deliveryAddress: '753 Cộng Hòa, Quận Tân Bình, TP.HCM',
        paymentMethod: PaymentMethod.cash,
        totalAmount: 98000.0,
        items: [
          OrderItemEntity(
            id: 12,
            menuItemId: 501,
            menuItemName: 'Pizza Hawaiian',
            price: 85000.0,
            quantity: 1,
          ),
          OrderItemEntity(
            id: 13,
            menuItemId: 502,
            menuItemName: 'Pepsi Cola',
            price: 13000.0,
            quantity: 1,
          ),
        ],
        notes: '',
      ),

      // Order 6: Cancelled
      const OrderEntity(
        id: 6,
        status: OrderStatus.cancelled,
        customerName: 'Lý Minh J',
        customerPhone: '0990123456',
        deliveryAddress: '951 Lê Văn Việt, Quận 9, TP.HCM',
        paymentMethod: PaymentMethod.cash,
        totalAmount: 67000.0,
        items: [
          OrderItemEntity(
            id: 14,
            menuItemId: 601,
            menuItemName: 'Bún Bò Huế',
            price: 55000.0,
            quantity: 1,
          ),
          OrderItemEntity(
            id: 15,
            menuItemId: 602,
            menuItemName: 'Nước Suối',
            price: 12000.0,
            quantity: 1,
          ),
        ],
        notes: 'Khách hàng hủy đơn',
      ),
    ];
  }

  /// Lấy order theo ID
  OrderEntity? getMockOrderById(num id) {
    try {
      return getMockOrders().firstWhere((order) => order.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Lấy orders theo status
  List<OrderEntity> getMockOrdersByStatus(OrderStatus status) {
    return getMockOrders().where((order) => order.status == status).toList();
  }
}


class OrderStatusConstants {
  OrderStatusConstants._();

  // Primary statuses sent by Backend
  static const String pending = "PENDING";
  static const String pendingPayment = "PENDING_PAYMENT";
  static const String confirmed = "CONFIRMED";
  static const String confirmedByRestaurant = "CONFIRMED_BY_RESTAURANT";
  
  static const String findingShipper = "FINDING_SHIPPER";
  static const String assignedToShipper = "ASSIGNED_TO_SHIPPER";
  static const String inDelivery = "IN_DELIVERY";
  static const String delivering = "DELIVERING";
  static const String delivered = "DELIVERED";
  
  static const String cancelled = "CANCELLED";
  static const String paymentFailed = "PAYMENT_FAILED";
  static const String rejectedByRestaurant = "REJECTED_BY_RESTAURANT";
  static const String shipperNotFound = "SHIPPER_NOT_FOUND";
}

class PaymentMethodConstants {
  PaymentMethodConstants._();
  
  static const String cod = "COD";
  static const String online = "ONLINE";
  static const String card = "CARD";
  static const String wallet = "WALLET";
}

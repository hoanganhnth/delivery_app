/// Enum cho trạng thái delivery tracking
enum DeliveryStatus {
  pending('pending', 'Chờ phân công shipper'),
  assigned('assigned', 'Đã phân công'),
  pickedUp('picked_up', 'Đã lấy hàng'),
  delivering('delivering', 'Đang giao hàng'),
  delivered('delivered', 'Đã giao thành công'),
  cancelled('cancelled', 'Đã hủy');

  const DeliveryStatus(this.value, this.displayName);

  /// Giá trị string để serialize/deserialize với API
  final String value;
  
  /// Tên hiển thị tiếng Việt
  final String displayName;

  /// Convert từ string value sang enum
  static DeliveryStatus? fromValue(String? value) {
    if (value == null) return null;
    
    for (DeliveryStatus status in DeliveryStatus.values) {
      if (status.value == value.toLowerCase()) {
        return status;
      }
    }
    return null;
  }

  /// Convert từ string value sang enum (với fallback)
  static DeliveryStatus fromValueOrDefault(String? value, [DeliveryStatus defaultStatus = DeliveryStatus.pending]) {
    return fromValue(value) ?? defaultStatus;
  }

  /// Kiểm tra xem có phải trạng thái đang giao hàng không
  bool get isDelivering => this == DeliveryStatus.delivering || this == DeliveryStatus.pickedUp;

  /// Kiểm tra xem có phải trạng thái đã hoàn thành không
  bool get isCompleted => this == DeliveryStatus.delivered || this == DeliveryStatus.cancelled;

  /// Kiểm tra xem có thể hủy delivery không
  bool get canCancel => this != DeliveryStatus.delivered && this != DeliveryStatus.cancelled;

  @override
  String toString() => value;
}

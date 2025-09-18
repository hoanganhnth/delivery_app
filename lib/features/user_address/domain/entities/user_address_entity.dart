/// Entity đại diện cho địa chỉ người dùng
class UserAddressEntity {
  final int? id;
  final int userId;
  final String label;
  final String addressLine;
  final String ward;
  final String district;
  final String city;
  final String? postalCode;
  final double? latitude;
  final double? longitude;
  final bool isDefault;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserAddressEntity({
    this.id,
    required this.userId,
    required this.label,
    required this.addressLine,
    required this.ward,
    required this.district,
    required this.city,
    this.postalCode,
    this.latitude,
    this.longitude,
    this.isDefault = false,
    this.createdAt,
    this.updatedAt,
  });

  /// Tạo bản sao với các thuộc tính được cập nhật
  UserAddressEntity copyWith({
    int? id,
    int? userId,
    String? label,
    String? addressLine,
    String? ward,
    String? district,
    String? city,
    String? postalCode,
    double? latitude,
    double? longitude,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserAddressEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      label: label ?? this.label,
      addressLine: addressLine ?? this.addressLine,
      ward: ward ?? this.ward,
      district: district ?? this.district,
      city: city ?? this.city,
      postalCode: postalCode ?? this.postalCode,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Lấy địa chỉ đầy đủ
  String get fullAddress {
    final parts = [addressLine, ward, district, city]
        .where((part) => part.isNotEmpty)
        .toList();
    return parts.join(', ');
  }

  /// Kiểm tra xem có tọa độ không
  bool get hasCoordinates => latitude != null && longitude != null;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserAddressEntity &&
        other.id == id &&
        other.userId == userId &&
        other.label == label &&
        other.addressLine == addressLine &&
        other.ward == ward &&
        other.district == district &&
        other.city == city &&
        other.postalCode == postalCode &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.isDefault == isDefault;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      userId,
      label,
      addressLine,
      ward,
      district,
      city,
      postalCode,
      latitude,
      longitude,
      isDefault,
    );
  }

  @override
  String toString() {
    return 'UserAddressEntity(id: $id, label: $label, fullAddress: $fullAddress, isDefault: $isDefault)';
  }
}

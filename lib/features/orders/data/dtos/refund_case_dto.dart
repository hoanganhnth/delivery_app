class RefundCaseDto {
  const RefundCaseDto({
    required this.refundId,
    required this.orderId,
    required this.paymentMethod,
    required this.trigger,
    required this.status,
    required this.currency,
    required this.refundAmount,
    this.createdAt,
    this.updatedAt,
    this.processedAt,
  });

  final String refundId;
  final int orderId;
  final String paymentMethod;
  final String trigger;
  final String status;
  final String currency;
  final double refundAmount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? processedAt;

  factory RefundCaseDto.fromJson(Map<String, dynamic> json) {
    return RefundCaseDto(
      refundId: _requiredString(json, 'refundId'),
      orderId: _requiredPositiveInt(json, 'orderId'),
      paymentMethod: _requiredString(json, 'paymentMethod'),
      trigger: _requiredString(json, 'trigger'),
      status: _requiredString(json, 'status'),
      currency: _requiredString(json, 'currency'),
      refundAmount: _requiredDouble(json, 'refundAmount'),
      createdAt: _optionalDateTime(json, 'createdAt'),
      updatedAt: _optionalDateTime(json, 'updatedAt'),
      processedAt: _optionalDateTime(json, 'processedAt'),
    );
  }

  static String _requiredString(Map<String, dynamic> json, String field) {
    final value = json[field];
    if (value is String && value.trim().isNotEmpty) return value.trim();
    throw FormatException('Missing or invalid refund field: $field');
  }

  static int _requiredPositiveInt(Map<String, dynamic> json, String field) {
    final value = json[field];
    final parsed = switch (value) {
      int value => value,
      num value when value == value.roundToDouble() => value.toInt(),
      String value => int.tryParse(value),
      _ => null,
    };
    if (parsed != null && parsed > 0) return parsed;
    throw FormatException('Missing or invalid refund field: $field');
  }

  static double _requiredDouble(Map<String, dynamic> json, String field) {
    final value = json[field];
    final parsed = switch (value) {
      num value => value.toDouble(),
      String value => double.tryParse(value),
      _ => null,
    };
    if (parsed != null && parsed >= 0 && parsed.isFinite) return parsed;
    throw FormatException('Missing or invalid refund field: $field');
  }

  static DateTime? _optionalDateTime(Map<String, dynamic> json, String field) {
    final value = json[field];
    if (value == null) return null;
    if (value is! String) {
      throw FormatException('Invalid refund timestamp: $field');
    }
    final parsed = DateTime.tryParse(value);
    if (parsed == null) {
      throw FormatException('Invalid refund timestamp: $field');
    }
    return parsed;
  }
}

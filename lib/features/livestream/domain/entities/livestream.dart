/// Contract model for a livestream room returned by livestream-service.
///
/// This model deliberately accepts only Agora. A provider value from an
/// incompatible/legacy response is rejected instead of silently selecting a
/// different RTC implementation.
final class Livestream {
  const Livestream({
    required this.id,
    required this.restaurantId,
    required this.title,
    required this.status,
    required this.streamProvider,
    this.sellerId,
    this.description,
    this.roomId,
    this.channelName,
    this.startedAt,
    this.endedAt,
    this.viewCount,
    this.pinnedProducts = const [],
  });

  final String id;
  final int? sellerId;
  final int restaurantId;
  final String title;
  final String? description;
  final LivestreamStatus status;
  final LivestreamProvider streamProvider;
  final String? roomId;
  final String? channelName;
  final DateTime? startedAt;
  final DateTime? endedAt;
  final int? viewCount;
  final List<LivestreamProduct> pinnedProducts;

  factory Livestream.fromJson(Map<String, dynamic> json) {
    final id = _requiredString(json, 'id');
    if (!_uuid.hasMatch(id)) {
      throw const FormatException('Invalid livestream identity');
    }
    final provider = _requiredString(json, 'streamProvider');
    if (provider != 'AGORA') {
      throw const FormatException('Unsupported livestream provider');
    }
    final products = json['pinnedProducts'];
    if (products != null && products is! List) {
      throw const FormatException('Invalid livestream pinnedProducts');
    }
    return Livestream(
      id: id,
      sellerId: _optionalInt(json['sellerId']),
      restaurantId: _requiredInt(json, 'restaurantId'),
      title: _requiredString(json, 'title'),
      description: json['description'] as String?,
      status: LivestreamStatus.parse(_requiredString(json, 'status')),
      streamProvider: LivestreamProvider.agora,
      roomId: json['roomId'] as String?,
      channelName: json['channelName'] as String?,
      startedAt: _optionalDate(json['startedAt']),
      endedAt: _optionalDate(json['endedAt']),
      viewCount: _optionalInt(json['viewCount']),
      pinnedProducts: products is List
          ? products
                .map((item) {
                  if (item is! Map<String, dynamic>) {
                    throw const FormatException('Invalid livestream product');
                  }
                  return LivestreamProduct.fromJson(item);
                })
                .toList(growable: false)
          : const [],
    );
  }
}

enum LivestreamStatus {
  created,
  live,
  ended;

  static LivestreamStatus parse(String value) => switch (value) {
    'CREATED' => LivestreamStatus.created,
    'LIVE' => LivestreamStatus.live,
    'ENDED' => LivestreamStatus.ended,
    _ => throw const FormatException('Invalid livestream status'),
  };
}

enum LivestreamProvider { agora }

final class LivestreamProduct {
  const LivestreamProduct({
    required this.id,
    required this.livestreamId,
    required this.productId,
    required this.productName,
    required this.restaurantId,
    required this.restaurantName,
    required this.priceAtLive,
    required this.isPinned,
    this.productImage,
    this.pinnedAt,
  });

  final int id;
  final String livestreamId;
  final int productId;
  final String productName;
  final String? productImage;
  final int restaurantId;
  final String restaurantName;
  final double priceAtLive;
  final bool isPinned;
  final DateTime? pinnedAt;

  factory LivestreamProduct.fromJson(Map<String, dynamic> json) {
    final livestreamId = _requiredString(json, 'livestreamId');
    if (!_uuid.hasMatch(livestreamId)) {
      throw const FormatException('Invalid livestream identity');
    }
    final price = json['priceAtLive'];
    if (price is! num || !price.isFinite || price <= 0) {
      throw const FormatException('Invalid livestream product price');
    }
    final isPinned = json['isPinned'];
    if (isPinned is! bool) {
      throw const FormatException('Invalid livestream isPinned');
    }
    return LivestreamProduct(
      id: _requiredInt(json, 'id'),
      livestreamId: livestreamId,
      productId: _requiredInt(json, 'productId'),
      productName: _requiredString(json, 'productName'),
      productImage: json['productImage'] as String?,
      restaurantId: _requiredInt(json, 'restaurantId'),
      restaurantName: _requiredString(json, 'restaurantName'),
      priceAtLive: price.toDouble(),
      isPinned: isPinned,
      pinnedAt: _optionalDate(json['pinnedAt']),
    );
  }
}

String _requiredString(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is! String || value.trim().isEmpty) {
    throw FormatException('Invalid livestream $key');
  }
  return value.trim();
}

int _requiredInt(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is! num ||
      !value.isFinite ||
      value <= 0 ||
      value != value.roundToDouble()) {
    throw FormatException('Invalid livestream $key');
  }
  return value.toInt();
}

int? _optionalInt(Object? value) {
  if (value == null) return null;
  if (value is! num ||
      !value.isFinite ||
      value < 0 ||
      value != value.roundToDouble()) {
    throw const FormatException('Invalid livestream counter');
  }
  return value.toInt();
}

DateTime? _optionalDate(Object? value) {
  if (value == null) return null;
  final parsed = value is String ? DateTime.tryParse(value) : null;
  if (parsed == null) {
    throw const FormatException('Invalid livestream timestamp');
  }
  return parsed.toUtc();
}

final _uuid = RegExp(
  r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[1-5][0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$',
);

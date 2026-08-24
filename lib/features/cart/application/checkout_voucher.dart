import 'package:delivery_app/core/constants/api_constants.dart';
import 'package:dio/dio.dart';

/// Contract-validated voucher available to the checkout application flow.
class CheckoutVoucher {
  const CheckoutVoucher({
    required this.id,
    required this.code,
    required this.name,
    required this.rewardType,
    required this.discountValue,
    required this.scopeType,
    required this.layer,
    required this.fundingSource,
    this.scopeRefId,
    this.minOrderValue,
  });

  final int id;
  final String code;
  final String name;
  final String rewardType;
  final double discountValue;
  final String scopeType;
  final String layer;
  final String fundingSource;
  final int? scopeRefId;
  final double? minOrderValue;

  factory CheckoutVoucher.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final code = json['code'];
    final name = json['name'];
    final rewardType = json['rewardType'];
    final discountValue = json['discountValue'];
    final creatorType = json['creatorType'];
    final scopeType = json['scopeType'];
    if (id is! num ||
        id.toInt() <= 0 ||
        code is! String ||
        code.trim().isEmpty ||
        name is! String ||
        name.trim().isEmpty ||
        rewardType is! String ||
        discountValue is! num ||
        discountValue < 0 ||
        creatorType is! String ||
        !const {'PLATFORM', 'SHOP'}.contains(creatorType) ||
        scopeType is! String ||
        !const {'ALL', 'SHOP'}.contains(scopeType)) {
      throw const FormatException('Invalid voucher wallet contract');
    }
    final scopeRefId = json['scopeRefId'];
    if (scopeType == 'SHOP' &&
        (scopeRefId is! num || scopeRefId.toInt() <= 0)) {
      throw const FormatException(
        'Restaurant voucher has no restaurant identity',
      );
    }
    final minOrderValue = json['minOrderValue'];
    final rewardLayer = json['layerCode'] is String
        ? json['layerCode'] as String
        : json['layer'] is String
        ? json['layer'] as String
        : rewardType == 'FREESHIP'
        ? 'FREESHIP'
        : creatorType == 'SHOP' || scopeType == 'SHOP'
        ? 'SHOP_DISCOUNT'
        : 'PLATFORM_DISCOUNT';
    final fundingSource = json['fundingSource'] is String
        ? json['fundingSource'] as String
        : rewardLayer == 'SHOP_DISCOUNT'
        ? 'SHOP'
        : 'PLATFORM';
    if (!const {
      'SHOP_DISCOUNT',
      'PLATFORM_DISCOUNT',
      'FREESHIP',
    }.contains(rewardLayer)) {
      throw const FormatException('Invalid voucher layer');
    }
    return CheckoutVoucher(
      id: id.toInt(),
      code: code,
      name: name,
      rewardType: rewardType,
      discountValue: discountValue.toDouble(),
      scopeType: scopeType,
      layer: rewardLayer,
      fundingSource: fundingSource,
      scopeRefId: scopeRefId is num ? scopeRefId.toInt() : null,
      minOrderValue: minOrderValue is num ? minOrderValue.toDouble() : null,
    );
  }

  bool appliesToRestaurant(int restaurantId) =>
      scopeType == 'ALL' || scopeRefId == restaurantId;

  String get displayBenefit => switch (rewardType) {
    'FIXED' => '-${discountValue.toStringAsFixed(0)}đ',
    'PERCENTAGE' => '-${discountValue.toStringAsFixed(0)}%',
    'FREESHIP' => 'Freeship',
    _ => rewardType,
  };
}

class CheckoutVoucherCapability {
  const CheckoutVoucherCapability({
    required this.enabled,
    required this.maxVouchers,
    required this.layers,
    required this.selectionModes,
    required this.conflictsWithFlashSale,
  });

  final bool enabled;
  final int maxVouchers;
  final List<String> layers;
  final List<String> selectionModes;
  final bool conflictsWithFlashSale;

  factory CheckoutVoucherCapability.fromJson(Map<String, dynamic> json) {
    final enabled = json['enabled'];
    final maxVouchers = json['maxVouchers'];
    final layers = json['layers'];
    final selectionModes = json['selectionModes'];
    final conflicts = json['conflictsWithFlashSale'];
    if (enabled is! bool ||
        maxVouchers is! num ||
        maxVouchers.toInt() < 1 ||
        layers is! List ||
        selectionModes is! List ||
        conflicts is! bool) {
      throw const FormatException('Invalid voucher capability contract');
    }
    return CheckoutVoucherCapability(
      enabled: enabled,
      maxVouchers: maxVouchers.toInt(),
      layers: layers.whereType<String>().toList(growable: false),
      selectionModes: selectionModes.whereType<String>().toList(
        growable: false,
      ),
      conflictsWithFlashSale: conflicts,
    );
  }
}

abstract interface class CheckoutVoucherGateway {
  Future<List<CheckoutVoucher>> getWallet();
  Future<CheckoutVoucherCapability> getCapability();
  Future<void> collect(String code);
}

class CheckoutVoucherClient implements CheckoutVoucherGateway {
  const CheckoutVoucherClient(this._dio);

  final Dio _dio;

  @override
  Future<CheckoutVoucherCapability> getCapability() async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiConstants.voucherCapability,
    );
    final envelope = response.data;
    if (envelope == null ||
        envelope['status'] != 1 ||
        envelope['data'] is! Map) {
      throw const FormatException('Invalid voucher capability envelope');
    }
    return CheckoutVoucherCapability.fromJson(
      Map<String, dynamic>.from(envelope['data'] as Map),
    );
  }

  @override
  Future<List<CheckoutVoucher>> getWallet() async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiConstants.myVouchers,
    );
    final envelope = response.data;
    if (envelope == null ||
        envelope['status'] != 1 ||
        envelope['data'] is! List) {
      throw const FormatException('Invalid voucher wallet envelope');
    }
    return (envelope['data'] as List<dynamic>)
        .map((item) {
          if (item is! Map) {
            throw const FormatException('Invalid voucher wallet item');
          }
          return CheckoutVoucher.fromJson(Map<String, dynamic>.from(item));
        })
        .toList(growable: false);
  }

  @override
  Future<void> collect(String code) async {
    final normalized = code.trim().toUpperCase();
    if (normalized.isEmpty) {
      throw const FormatException('Voucher code is required');
    }
    final response = await _dio.post<Map<String, dynamic>>(
      ApiConstants.collectVoucher(normalized),
    );
    final envelope = response.data;
    if (envelope == null || envelope['status'] != 1) {
      throw const FormatException('Voucher collect failed');
    }
  }
}

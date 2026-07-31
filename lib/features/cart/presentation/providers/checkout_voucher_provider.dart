import 'package:delivery_app/core/config/runtime_config.dart';
import 'package:delivery_app/core/constants/api_constants.dart';
import 'package:delivery_app/features/auth/presentation/providers/di/auth_network_providers.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckoutVoucher {
  const CheckoutVoucher({
    required this.id,
    required this.code,
    required this.name,
    required this.rewardType,
    required this.discountValue,
    required this.scopeType,
    this.scopeRefId,
    this.minOrderValue,
  });

  final int id;
  final String code;
  final String name;
  final String rewardType;
  final double discountValue;
  final String scopeType;
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
        creatorType != 'PLATFORM' ||
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
    return CheckoutVoucher(
      id: id.toInt(),
      code: code,
      name: name,
      rewardType: rewardType,
      discountValue: discountValue.toDouble(),
      scopeType: scopeType,
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

class CheckoutVoucherClient {
  const CheckoutVoucherClient(this._dio);

  final Dio _dio;

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
}

final checkoutVoucherWalletProvider =
    FutureProvider.autoDispose<List<CheckoutVoucher>>((ref) async {
      if (!RuntimeConfig.voucherCheckoutEnabled) return const [];
      final client = CheckoutVoucherClient(ref.watch(authAwareDioProvider));
      return client.getWallet();
    });

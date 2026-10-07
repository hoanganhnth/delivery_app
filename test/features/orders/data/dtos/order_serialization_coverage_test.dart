import 'dart:convert';

import 'package:delivery_app/features/orders/data/dtos/checkout_preview_dto.dart';
import 'package:delivery_app/features/orders/data/dtos/current_delivery_dto.dart';
import 'package:delivery_app/features/orders/data/dtos/refund_case_dto.dart';
import 'package:delivery_app/features/orders/data/dtos/restaurant_rating_request_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('checkout request round trips nested items and voucher selection', () {
    final json = <String, dynamic>{
      'livestreamId': '00000000-0000-4000-8000-000000000001',
      'restaurantId': 201,
      'deliveryLat': 10.78,
      'deliveryLng': 106.71,
      'couponCode': null,
      'voucherId': 9,
      'selectedVoucherIds': [9],
      'selectionMode': 'MANUAL',
      'items': [
        {'menuItemId': 301, 'quantity': 2, 'flashSaleItemId': 88},
      ],
    };
    final request = CheckoutPreviewRequest.fromJson(json);
    expect(jsonDecode(jsonEncode(request)), json);
    expect(request.items.single.flashSaleItemId, 88);
  });

  test(
    'checkout response round trips all server totals and nested details',
    () {
      final json = <String, dynamic>{
        'quoteId': 'quote',
        'expiresAt': '2099-01-01T00:00:00.000Z',
        'restaurantId': 201,
        'restaurantName': 'Kitchen',
        'items': [
          {
            'menuItemId': 301,
            'menuItemName': 'Rice',
            'imageUrl': 'image',
            'unitPrice': 50000.0,
            'quantity': 2,
            'lineTotal': 100000.0,
          },
        ],
        'subtotal': 100000.0,
        'shippingFee': 15000.0,
        'discountAmount': 5000.0,
        'totalPrice': 110000.0,
        'couponCode': null,
        'couponMessage': null,
        'voucherId': 9,
        'selectedVoucherIds': [9],
        'selectionMode': 'MANUAL',
        'itemDiscount': 3000.0,
        'shippingDiscount': 2000.0,
        'customerShippingFee': 13000.0,
        'grossShippingFee': 15000.0,
        'platformSubsidy': 2000.0,
        'shopDiscount': 3000.0,
        'appliedVouchers': [
          {
            'voucherId': 9,
            'code': 'SAVE',
            'layer': 'ITEM',
            'fundingSource': 'SHOP',
            'discountBase': 100000.0,
            'discountAmount': 3000.0,
          },
        ],
        'priceChanges': [
          {
            'menuItemId': 301,
            'menuItemName': 'Rice',
            'oldPrice': 49000.0,
            'newPrice': 50000.0,
          },
        ],
        'unavailableItemIds': [],
      };
      final response = CheckoutPreviewResponse.fromJson(json);
      expect(jsonDecode(jsonEncode(response)), json);
      expect(response.appliedVouchers?.single.discountAmount, 3000);
      expect(response.priceChanges?.single.newPrice, 50000);
    },
  );

  test('rating serializes backend field names', () {
    final json = <String, dynamic>{
      'orderId': 601,
      'rating': 5,
      'comment': 'Good',
    };
    expect(RestaurantRatingRequestDto.fromJson(json).toJson(), json);
  });

  test('delivery round trips timestamps and coordinates', () {
    final json = <String, dynamic>{
      'id': 1,
      'orderId': 601,
      'shipperId': 9,
      'status': 'ASSIGNED',
      'pickupLat': 10.77,
      'pickupLng': 106.7,
      'deliveryLat': 10.78,
      'deliveryLng': 106.71,
      'shipperCurrentLat': 10.77,
      'shipperCurrentLng': 106.7,
      'pickupAddress': ' Shop ',
      'deliveryAddress': ' Home ',
      'estimatedDeliveryTime': '2026-09-14T01:00:00Z',
      'assignedAt': '2026-09-14T00:00:00Z',
      'pickedUpAt': '2026-09-14T00:10:00Z',
      'deliveredAt': '2026-09-14T00:30:00Z',
      'notes': 'warm',
      'createdAt': '2026-09-14T00:00:00Z',
      'updatedAt': '2026-09-14T00:30:00Z',
    };
    final dto = CurrentDeliveryDto.fromJson(json);
    expect(dto.toJson(), json);
    final entity = dto.toEntity();
    expect(entity.pickupAddress, 'Shop');
    expect(entity.deliveredAt, DateTime.utc(2026, 9, 14, 0, 30));
  });

  test(
    'refund accepts numeric strings and rejects invalid amounts and dates',
    () {
      final json = <String, dynamic>{
        'refundId': ' refund ',
        'orderId': '601',
        'paymentMethod': 'COD',
        'trigger': 'CANCELLED',
        'status': 'PENDING',
        'currency': 'VND',
        'refundAmount': '100000',
        'processedAt': '2026-09-14T00:00:00Z',
      };
      final dto = RefundCaseDto.fromJson(json);
      expect(dto.refundId, 'refund');
      expect(dto.orderId, 601);
      expect(dto.refundAmount, 100000);
      expect(dto.processedAt, DateTime.utc(2026, 9, 14));
      expect(RefundCaseDto.fromJson({...json, 'orderId': 601.0}).orderId, 601);
      for (final change in [
        {'orderId': 1.5},
        {'orderId': null},
        {'refundId': ''},
        {'refundAmount': null},
        {'refundAmount': -1},
        {'refundAmount': 'NaN'},
        {'processedAt': 1},
        {'processedAt': 'invalid'},
      ]) {
        expect(
          () => RefundCaseDto.fromJson({...json, ...change}),
          throwsFormatException,
        );
      }
    },
  );
}

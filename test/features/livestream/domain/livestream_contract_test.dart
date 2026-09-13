import 'package:delivery_app/features/livestream/domain/entities/livestream.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const id = '00000000-0000-4000-8000-000000000001';
  Map<String, dynamic> product() => {
    'id': 1,
    'livestreamId': id,
    'productId': 10,
    'productName': 'Món test',
    'restaurantId': 42,
    'restaurantName': 'Quán test',
    'priceAtLive': 45000,
    'isPinned': true,
  };
  Map<String, dynamic> room() => {
    'id': id,
    'restaurantId': 42,
    'title': 'Phiên test',
    'status': 'LIVE',
    'streamProvider': 'AGORA',
    'pinnedProducts': [product()],
  };

  test('parses multiple pins and zero viewer count', () {
    final json = room()..['viewCount'] = 0;
    json['pinnedProducts'] = [product(), product()..['productId'] = 11];
    final parsed = Livestream.fromJson(json);
    expect(parsed.viewCount, 0);
    expect(parsed.pinnedProducts.map((p) => p.productId), [10, 11]);
  });
  test('rejects fractional or nonfinite identifiers instead of truncating', () {
    for (final value in [1.5, double.nan, double.infinity, 0, -1]) {
      expect(
        () => Livestream.fromJson(room()..['restaurantId'] = value),
        throwsFormatException,
      );
      expect(
        () => LivestreamProduct.fromJson(product()..['productId'] = value),
        throwsFormatException,
      );
    }
  });
  test('rejects malformed pinned list and entries', () {
    for (final value in [
      'not-a-list',
      {},
      [null],
      [1],
    ]) {
      expect(
        () => Livestream.fromJson(room()..['pinnedProducts'] = value),
        throwsFormatException,
      );
    }
  });
  test('rejects malformed pin flags and nonfinite prices', () {
    for (final value in ['true', 1, null]) {
      expect(
        () => LivestreamProduct.fromJson(product()..['isPinned'] = value),
        throwsFormatException,
      );
    }
    for (final value in [double.nan, double.infinity, -1, 0]) {
      expect(
        () => LivestreamProduct.fromJson(product()..['priceAtLive'] = value),
        throwsFormatException,
      );
    }
  });
  test('rejects malformed optional counters and dates', () {
    for (final value in ['1', 1.5, -1]) {
      expect(
        () => Livestream.fromJson(room()..['viewCount'] = value),
        throwsFormatException,
      );
    }
    expect(
      () => Livestream.fromJson(room()..['startedAt'] = 'yesterday'),
      throwsFormatException,
    );
  });
}

import 'dart:async';

import 'package:delivery_app/core/network/resources/base_response_dto.dart';
import 'package:delivery_app/features/cart/presentation/providers/checkout_preview_provider.dart';
import 'package:delivery_app/features/orders/data/datasources/order_api_service.dart';
import 'package:delivery_app/features/orders/data/dtos/checkout_preview_dto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('checkout preview is single-submit and stores canonical server totals', () async {
    final pending = Completer<BaseResponseDto<CheckoutPreviewResponse>>();
    final service = _FakeOrderApiService((_) => pending.future);
    final container = _container(service);
    addTearDown(container.dispose);
    container.listen(checkoutPreviewProvider, (_, _) {});
    final notifier = container.read(checkoutPreviewProvider.notifier);

    final first = notifier.loadPreview(_request);
    final duplicate = await notifier.loadPreview(_request);

    expect(duplicate, isNull);
    expect(service.calls, 1);
    expect(container.read(checkoutPreviewProvider).isLoading, isTrue);

    pending.complete(
      const BaseResponseDto(
        status: 1,
        message: 'ok',
        data: _preview,
      ),
    );
    final result = await first;

    expect(result?.totalPrice, 65000);
    expect(container.read(checkoutPreviewProvider).value?.shippingFee, 15000);
  });

  test('invalid preview response is observable and can be retried', () async {
    var response = const BaseResponseDto<CheckoutPreviewResponse>(
      status: 0,
      message: 'Không thể tính phí giao hàng',
    );
    final service = _FakeOrderApiService((_) async => response);
    final container = _container(service);
    addTearDown(container.dispose);
    container.listen(checkoutPreviewProvider, (_, _) {});
    final notifier = container.read(checkoutPreviewProvider.notifier);

    expect(await notifier.loadPreview(_request), isNull);
    expect(container.read(checkoutPreviewProvider).hasError, isTrue);
    expect(
      container.read(checkoutPreviewProvider).error.toString(),
      contains('Không thể tính phí giao hàng'),
    );

    response = const BaseResponseDto(
      status: 1,
      message: 'ok',
      data: _preview,
    );
    expect((await notifier.loadPreview(_request))?.totalPrice, 65000);
    expect(container.read(checkoutPreviewProvider).hasValue, isTrue);
    expect(service.calls, 2);
  });

  test('mismatched server items fail closed instead of enabling checkout', () async {
    final malformed = _preview.copyWith(
      items: const [
        PreviewItemDetail(
          menuItemId: 999,
          menuItemName: 'Sai món',
          unitPrice: 50000,
          quantity: 1,
          lineTotal: 50000,
        ),
      ],
    );
    final service = _FakeOrderApiService(
      (_) async => BaseResponseDto(
        status: 1,
        message: 'ok',
        data: malformed,
      ),
    );
    final container = _container(service);
    addTearDown(container.dispose);
    container.listen(checkoutPreviewProvider, (_, _) {});

    final result = await container
        .read(checkoutPreviewProvider.notifier)
        .loadPreview(_request);

    expect(result, isNull);
    expect(container.read(checkoutPreviewProvider).hasError, isTrue);
    expect(container.read(checkoutPreviewProvider).error, isA<FormatException>());
  });
}

const _request = CheckoutPreviewRequest(
  restaurantId: 201,
  deliveryLat: 10.78,
  deliveryLng: 106.71,
  items: [CheckoutPreviewItemRequest(menuItemId: 301, quantity: 1)],
);

const _preview = CheckoutPreviewResponse(
  restaurantId: 201,
  restaurantName: 'Bếp test',
  items: [
    PreviewItemDetail(
      menuItemId: 301,
      menuItemName: 'Cơm test',
      unitPrice: 50000,
      quantity: 1,
      lineTotal: 50000,
    ),
  ],
  subtotal: 50000,
  shippingFee: 15000,
  discountAmount: 0,
  totalPrice: 65000,
  unavailableItemIds: [],
);

ProviderContainer _container(_FakeOrderApiService service) {
  return ProviderContainer(
    overrides: [checkoutOrderApiServiceProvider.overrideWithValue(service)],
  );
}

class _FakeOrderApiService implements OrderApiService {
  _FakeOrderApiService(this.handler);

  final Future<BaseResponseDto<CheckoutPreviewResponse>> Function(
    CheckoutPreviewRequest request,
  ) handler;
  int calls = 0;

  @override
  Future<BaseResponseDto<CheckoutPreviewResponse>> checkoutPreview(
    CheckoutPreviewRequest request,
  ) {
    calls += 1;
    return handler(request);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

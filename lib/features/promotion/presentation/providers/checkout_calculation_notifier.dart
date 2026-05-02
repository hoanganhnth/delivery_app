import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/dtos/calculate_response_dto.dart';
import '../../data/dtos/cart_context_request_dto.dart';
import 'promotion_providers.dart';

part 'checkout_calculation_notifier.g.dart';

@riverpod
class CheckoutCalculationNotifier extends _$CheckoutCalculationNotifier {
  @override
  FutureOr<CalculateResponseDto?> build() {
    return null;
  }

  Future<void> calculate(CartContextRequestDto request) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(promotionRepositoryProvider);
      final response = await repository.calculate(request);
      state = AsyncValue.data(response);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}

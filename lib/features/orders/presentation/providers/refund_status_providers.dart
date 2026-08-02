import 'package:delivery_app/core/error/dio_exception_handler.dart';
import 'package:delivery_app/core/network/_riverpod/authenticated_network_providers.dart';
import 'package:delivery_app/features/orders/data/datasources/refund_api_service.dart';
import 'package:delivery_app/features/orders/data/dtos/refund_case_dto.dart';
import 'package:delivery_app/features/orders/domain/entities/refund_case_entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract interface class CustomerRefundStatusPort {
  Future<List<RefundCaseEntity>> getMyRefundCases({int limit = 50});
}

class ApiCustomerRefundStatusAdapter implements CustomerRefundStatusPort {
  ApiCustomerRefundStatusAdapter(this._apiService);

  final RefundApiService _apiService;

  @override
  Future<List<RefundCaseEntity>> getMyRefundCases({int limit = 50}) async {
    final boundedLimit = limit.clamp(1, 100).toInt();
    try {
      final response = await _apiService.getMyRefundCases(boundedLimit);
      final cases = response.data;
      if (response.status != 1 || cases == null) {
        throw FormatException('Invalid customer refund status response');
      }
      return cases.map(_toEntity).toList(growable: false);
    } on DioException catch (error) {
      throw DioExceptionHandler.mapDioExceptionToException(error);
    }
  }

  RefundCaseEntity _toEntity(RefundCaseDto refundCase) {
    return RefundCaseEntity(
      refundId: refundCase.refundId,
      orderId: refundCase.orderId,
      paymentMethod: refundCase.paymentMethod,
      trigger: refundCase.trigger,
      status: RefundCaseStatus.fromBackend(refundCase.status),
      currency: refundCase.currency,
      refundAmount: refundCase.refundAmount,
      createdAt: refundCase.createdAt,
      updatedAt: refundCase.updatedAt,
      processedAt: refundCase.processedAt,
    );
  }
}

final customerRefundStatusPortProvider = Provider<CustomerRefundStatusPort>((
  ref,
) {
  final dio = ref.watch(authenticatedDioProvider);
  return ApiCustomerRefundStatusAdapter(RefundApiService(dio));
});

final customerRefundCasesProvider = FutureProvider<List<RefundCaseEntity>>(
  (ref) => ref.watch(customerRefundStatusPortProvider).getMyRefundCases(),
);

final customerRefundForOrderProvider = FutureProvider.autoDispose
    .family<RefundCaseEntity?, num>((ref, orderId) async {
      final cases = await ref.watch(customerRefundCasesProvider.future);
      for (final refundCase in cases) {
        if (refundCase.orderId == orderId) return refundCase;
      }
      return null;
    });

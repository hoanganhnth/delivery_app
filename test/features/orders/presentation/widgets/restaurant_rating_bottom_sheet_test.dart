import 'dart:async';

import 'package:delivery_app/features/orders/data/dtos/restaurant_rating_request_dto.dart';
import 'package:delivery_app/features/orders/domain/entities/order_entity.dart';
import 'package:delivery_app/features/orders/presentation/providers/ratings/restaurant_rating_submission_provider.dart';
import 'package:delivery_app/features/orders/presentation/widgets/order_detail/restaurant_rating_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../support/app_harness.dart';
import '../../../../support/fulfilment_builders.dart';

void main() {
  testWidgets(
    'rating submission records canonical input and stays single-submit',
    (tester) async {
      final submission = _FakeRatingSubmission()..pending = Completer<void>();
      await _pumpLauncher(tester, submission);

      await tester.tap(find.text('Mở đánh giá'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byType(TextField),
        '  Nhà hàng chuẩn bị rất tốt  ',
      );
      await tester.tap(find.text('Gửi đánh giá'));
      await tester.pump();

      expect(submission.calls, hasLength(1));
      expect(submission.calls.single.restaurantId, 201);
      expect(submission.calls.single.request.orderId, 601);
      expect(submission.calls.single.request.rating, 5);
      expect(
        submission.calls.single.request.comment,
        'Nhà hàng chuẩn bị rất tốt',
      );
      expect(
        tester
            .widget<ElevatedButton>(
              find.ancestor(
                of: find.byType(CircularProgressIndicator),
                matching: find.byType(ElevatedButton),
              ),
            )
            .onPressed,
        isNull,
      );

      await tester.tap(
        find.ancestor(
          of: find.byType(CircularProgressIndicator),
          matching: find.byType(ElevatedButton),
        ),
      );
      expect(submission.calls, hasLength(1));

      submission.pending!.complete();
      await tester.pumpAndSettle();
      expect(find.text('Gửi đánh giá'), findsNothing);
    },
  );

  testWidgets('rating failure keeps the action available for retry', (
    tester,
  ) async {
    final submission = _FakeRatingSubmission()..failuresRemaining = 1;
    await _pumpLauncher(tester, submission);
    await tester.tap(find.text('Mở đánh giá'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Gửi đánh giá'));
    await tester.pumpAndSettle();

    expect(submission.calls, hasLength(1));
    expect(find.text('Gửi đánh giá'), findsOneWidget);
    expect(
      tester
          .widget<ElevatedButton>(
            find.widgetWithText(ElevatedButton, 'Gửi đánh giá'),
          )
          .onPressed,
      isNotNull,
    );

    await tester.tap(find.text('Gửi đánh giá'));
    await tester.pumpAndSettle();
    expect(submission.calls, hasLength(2));
    expect(find.text('Gửi đánh giá'), findsNothing);
  });
}

Future<void> _pumpLauncher(
  WidgetTester tester,
  RestaurantRatingSubmissionPort submission,
) async {
  await pumpTestApp(
    tester,
    overrides: [
      restaurantRatingSubmissionProvider.overrideWithValue(submission),
    ],
    child: Builder(
      builder: (context) => ElevatedButton(
        onPressed: () => showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          builder: (_) => RestaurantRatingBottomSheet(
            order: buildOrder(
              status: OrderStatus.delivered,
              rawStatus: 'DELIVERED',
            ),
          ),
        ),
        child: const Text('Mở đánh giá'),
      ),
    ),
  );
}

class _RatingCall {
  const _RatingCall(this.restaurantId, this.request);

  final int restaurantId;
  final RestaurantRatingRequestDto request;
}

class _FakeRatingSubmission implements RestaurantRatingSubmissionPort {
  int failuresRemaining = 0;
  Completer<void>? pending;
  final List<_RatingCall> calls = [];

  @override
  Future<void> submit({
    required int restaurantId,
    required RestaurantRatingRequestDto request,
  }) async {
    calls.add(_RatingCall(restaurantId, request));
    if (failuresRemaining > 0) {
      failuresRemaining -= 1;
      throw StateError('rating unavailable');
    }
    await pending?.future;
  }
}

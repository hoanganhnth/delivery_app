import 'dart:async';

import 'package:delivery_app/features/orders/presentation/pages/order_detail_rating_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../support/app_harness.dart';

void main() {
  testWidgets('rating form emits canonical input and stays single-submit', (
    tester,
  ) async {
    final submission = _FakeRatingSubmission()..pending = Completer<String?>();
    await _pumpLauncher(tester, submission);

    await tester.tap(find.text('Mở đánh giá'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byType(TextField),
      '  Nhà hàng chuẩn bị rất tốt  ',
    );
    await tester.tap(find.text('Gửi đánh giá'));
    await tester.pump();

    expect(submission.calls, [
      const _RatingCall(5, 'Nhà hàng chuẩn bị rất tốt'),
    ]);
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

    submission.pending!.complete(null);
    await tester.pumpAndSettle();
    expect(find.text('Gửi đánh giá'), findsNothing);
  });

  testWidgets('rating form displays submit failure and keeps retry available', (
    tester,
  ) async {
    final submission = _FakeRatingSubmission()..failuresRemaining = 1;
    await _pumpLauncher(tester, submission);
    await tester.tap(find.text('Mở đánh giá'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Gửi đánh giá'));
    await tester.pumpAndSettle();

    expect(submission.calls, hasLength(1));
    expect(find.text('rating unavailable'), findsOneWidget);
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
  _FakeRatingSubmission submission,
) => pumpTestApp(
  tester,
  child: Builder(
    builder: (context) => ElevatedButton(
      onPressed: () => showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (_) => RestaurantRatingBottomSheet(
          restaurantName: 'Nhà hàng kiểm thử',
          onSubmit: submission.submit,
        ),
      ),
      child: const Text('Mở đánh giá'),
    ),
  ),
);

class _RatingCall {
  const _RatingCall(this.rating, this.comment);

  final int rating;
  final String comment;

  @override
  bool operator ==(Object other) =>
      other is _RatingCall &&
      other.rating == rating &&
      other.comment == comment;

  @override
  int get hashCode => Object.hash(rating, comment);
}

class _FakeRatingSubmission {
  int failuresRemaining = 0;
  Completer<String?>? pending;
  final List<_RatingCall> calls = [];

  Future<String?> submit(int rating, String comment) async {
    calls.add(_RatingCall(rating, comment));
    if (failuresRemaining > 0) {
      failuresRemaining -= 1;
      return 'rating unavailable';
    }
    return pending?.future;
  }
}

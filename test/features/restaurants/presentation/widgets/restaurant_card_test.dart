import 'package:delivery_app/features/restaurants/presentation/widgets/shared/restaurant_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('missing restaurant facts are omitted instead of fabricated', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: RestaurantCard(name: 'Nhà hàng thật')),
      ),
    );

    expect(find.text('Nhà hàng thật'), findsOneWidget);
    expect(find.byIcon(Icons.restaurant), findsOneWidget);
    expect(find.byIcon(Icons.star), findsNothing);
    expect(find.byIcon(Icons.schedule), findsNothing);
    expect(find.textContaining('4.5'), findsNothing);
    expect(find.textContaining('25-35'), findsNothing);
    expect(find.textContaining('1.5 km'), findsNothing);
    expect(find.textContaining('15k'), findsNothing);
  });
}

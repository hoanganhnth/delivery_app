import 'package:delivery_app/features/profile/application/profile_view_state.dart';
import 'package:delivery_app/features/profile/presentation/views/profile_personal_information_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import '../../../../support/app_harness.dart';

void main() {
  testWidgets('shows contact details on the dedicated information screen', (
    tester,
  ) async {
    await pumpTestApp(
      tester,
      child: const ProfilePersonalInformationView(
        data: ProfileViewData(
          displayName: 'Customer Test',
          email: 'customer@test.dev',
          phone: '0900000000',
        ),
      ),
    );

    expect(find.text('Customer Test'), findsOneWidget);
    expect(find.text('customer@test.dev'), findsOneWidget);
    expect(find.text('0900000000'), findsOneWidget);
  });

  testWidgets('shows loading and allows retry after a load failure', (
    tester,
  ) async {
    var retries = 0;
    await pumpTestApp(
      tester,
      child: ProfilePersonalInformationView(
        data: const ProfileViewData(),
        errorMessage: 'Network unavailable',
        onRetry: () => retries++,
      ),
    );
    expect(find.text('Network unavailable'), findsOneWidget);
    await tester.tap(find.text('Retry'));
    expect(retries, 1);

    await pumpTestApp(
      tester,
      child: const ProfilePersonalInformationView(
        data: ProfileViewData(),
        isLoading: true,
      ),
    );
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
  });
}
